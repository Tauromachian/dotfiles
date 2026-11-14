#!/usr/bin/env nu
# herdr equivalent of home/.local/bin/dev, for Nushell on Windows.
# Usage: dev-herdr.nu [react|nuxt|vue|next]
# Layout: editor pane split left of current pane (`v .`), `opencode` tab (`opencode .`), `dev` tab (`pn run dev` for frameworks only).
# Requires: herdr in PATH. Best run from inside a herdr pane so HERDR_TAB_ID is set.

def main [framework?: string] {
    let start_tab = ($env.HERDR_TAB_ID? | default "")

    # 1. Editor pane to the left of the current pane.
    # NOTE: original tmux script runs `v .` in the current (left) pane; here we use the
    # new pane so the caller's shell is left untouched.
    let editor_pane = (herdr pane split --direction left --no-focus | from json | get result.pane.pane_id)
    herdr pane run $editor_pane "v ."

    # 2. opencode tab.
    let opencode_root = (herdr tab create --label opencode --no-focus | from json | get result.root_pane.pane_id)
    herdr pane run $opencode_root "opencode ."

    # 3. dev-server tab (stays empty unless a known framework is passed).
    let dev_root = (herdr tab create --label dev --no-focus | from json | get result.root_pane.pane_id)
    if $framework in ["react", "nuxt", "vue", "next"] {
        herdr pane run $dev_root "pn run dev"
    }

    # 4. Jump back to the starting tab (like `tmux select-window -t 1`).
    if $start_tab != "" {
        herdr tab focus $start_tab
    }
}
