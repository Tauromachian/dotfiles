#!/usr/bin/env nu
# herdr rewrite of home/.local/bin/tmux-sessionizer.
# Fuzzy-pick a project dir with fzf, create a herdr workspace for it if needed, focus it.
# Usage: sessionizer.nu (or sessionizer.bat on Windows)

# Match an existing workspace by cwd first (exact), then by label.
def find-workspace [workspaces: list, label: string, dir: string] {
    let want = ($dir | path expand | str lowercase)
    for ws in $workspaces {
        let cwd = try { $ws | get cwd | path expand | str lowercase } catch { null }
        if $cwd == $want { return $ws }
    }
    for ws in $workspaces {
        let lbl = try { $ws | get label } catch { try { $ws | get name } catch { null } }
        if $lbl == $label { return $ws }
    }
    null
}

def main [] {
    if (which herdr | is-empty) {
        error make {msg: "herdr not found on PATH"}
    }
    if (which fzf | is-empty) {
        error make {msg: "fzf not found on PATH (winget install fzf)"}
    }

    let roots = [
        ("~/Desktop/Work" | path expand)
        ("~/Desktop/Playground" | path expand)
        ("~" | path expand)
    ]

    # Mirror `find <roots> -mindepth 1 -maxdepth 2 -type d`.
    # NOTE: bare `ls $dir` only — `path join "*"` glob patterns fail on some builds,
    # and one failing glob used to discard the whole root.
    let candidates = (
        $roots
        | where { $in | path exists }
        | each { |r|
            let depth1 = try {
                ls $r | where type == dir | each { $in.name }
            } catch { [] }
            let depth2 = ($depth1 | each { |d|
                try { ls $d | where type == dir | each { $in.name } } catch { [] }
            } | flatten)
            ($depth1 ++ $depth2)
        }
        | flatten
        | uniq
        | sort
    )
    if ($candidates | is-empty) {
        print --stderr "sessionizer: no candidate directories found under ~/Desktop/Work, ~/Desktop/Playground, ~"
        return
    }

    let session = try {
        $candidates | str join (char newline) | ^fzf | str trim
    } catch { |e|
        print $"fzf failed: ($e.msg)"
        ""
    }
    if ($session | is-empty) { return }

    let session_name = ($session | path basename | str replace --all "." "_")

    let workspaces = try {
        herdr workspace list | from json | get result.workspaces
    } catch { |e|
        print $"workspace list failed: ($e.msg)"
        []
    }

    let existing = (find-workspace $workspaces $session_name $session)
    let ws_id = if $existing == null {
        herdr workspace create --cwd $session --label $session_name --no-focus | from json | get result.workspace.workspace_id
    } else {
        try { $existing | get workspace_id } catch { null }
    }

    if $ws_id == null {
        # Unexpected list schema: fall back to creating fresh.
        let created = (herdr workspace create --cwd $session --label $session_name --no-focus | from json)
        herdr workspace focus ($created | get result.workspace.workspace_id)
    } else {
        herdr workspace focus $ws_id
    }
}
