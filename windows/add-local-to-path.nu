#!/usr/bin/env nu
# Ensure ~/.local/bin is on the user PATH (persisted via the user env var).
# Standalone: nu add-local-to-path.nu (called by install.nu).

def main [] {
    let dir = ($env.USERPROFILE | path join ".local" "bin" | path expand)
    let quoted = "'" + ($dir | str replace --all "'" "''") + "'"
    let on_path = (powershell -NoProfile -Command "[Environment]::GetEnvironmentVariable('Path','User')" | str trim | split row ";" | each { str lowercase } | any { $in == ($dir | str lowercase) })
    if $on_path {
        print $"    already on user PATH: ($dir)"
        return
    }
    print $"==> Adding ($dir) to user PATH..."
    try {
        powershell -NoProfile -Command $"[Environment]::SetEnvironmentVariable('Path', ([Environment]::GetEnvironmentVariable('Path','User').TrimEnd(';') + ';' + ($quoted)), 'User')"
    } catch { |e|
        print $"    FAILED: user PATH: ($e.msg)"
        exit 1
    }
}
