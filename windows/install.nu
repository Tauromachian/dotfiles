#!/usr/bin/env nu
# Windows workstation setup.
# Bootstrap nushell itself first (winget, or https://www.nushell.sh/book/installation.html),
# then run: nu install.nu
# NOTE: restart your terminal afterwards so PATH changes take effect.

# winget packages.
let packages = [
    { name: "Git", id: "Git.Git" }
    { name: "fzf", id: "junegunn.fzf" }
    { name: "ripgrep", id: "BurntSushi.ripgrep.MSVC" }
    { name: "tree-sitter-cli", id: "tree-sitter.tree-sitter-cli" }
    { name: "fnm", id: "Schniz.fnm" }
    { name: "Neovim", id: "Neovim.Neovim" }
    { name: "Alacritty", id: "Alacritty.Alacritty" }
    { name: "Chromium", id: "Hibbiki.Chromium" }
    { name: "AutoHotkey v2", id: "AutoHotkey.AutoHotkey" }
    { name: "GNU Make", id: "GnuWin32.Make" }
]

# Assumes the repo is checked out at %USERPROFILE%\.dotfiles.
let links = [
    { target: ($env.LOCALAPPDATA | path join "nvim"), source: ($env.USERPROFILE | path join ".dotfiles" "home" ".config" "nvim") }
    { target: ($env.APPDATA | path join "nushell" "config.nu"), source: ($env.USERPROFILE | path join ".dotfiles" "windows" "config.nu") }
    { target: ($env.APPDATA | path join "alacritty" "alacritty.toml"), source: ($env.USERPROFILE | path join ".dotfiles" "home" ".config" "alacritty" "alacritty.toml") }
    { target: ($env.APPDATA | path join "herdr" "config.toml"), source: ($env.USERPROFILE | path join ".dotfiles" "windows" "herdr" "config.toml") }
    { target: ($env.USERPROFILE | path join ".gitconfig"), source: ($env.USERPROFILE | path join ".dotfiles" "home" ".gitconfig") }
    { target: ($env.APPDATA | path join "Microsoft" "Windows" "Start Menu" "Programs" "Startup" "default.ahk"), source: ($env.USERPROFILE | path join ".dotfiles" "windows" "default.ahk") }
    { target: ($env.USERPROFILE | path join "Desktop" "default.ahk"), source: ($env.USERPROFILE | path join ".dotfiles" "windows" "default.ahk") }
    { target: ($env.USERPROFILE | path join ".local" "bin" "dev.bat"), source: ($env.USERPROFILE | path join ".dotfiles" "windows" ".local" "bin" "dev.bat") }
    { target: ($env.USERPROFILE | path join ".local" "bin" "dev.nu"), source: ($env.USERPROFILE | path join ".dotfiles" "windows" ".local" "bin" "dev.nu") }
    { target: ($env.USERPROFILE | path join ".local" "bin" "sessionizer.bat"), source: ($env.USERPROFILE | path join ".dotfiles" "windows" ".local" "bin" "sessionizer.bat") }
    { target: ($env.USERPROFILE | path join ".local" "bin" "sessionizer.nu"), source: ($env.USERPROFILE | path join ".dotfiles" "windows" ".local" "bin" "sessionizer.nu") }
]

def already-installed [id: string] {
    winget list --exact --id $id
    | complete
    | get stdout
    | str lowercase
    | str contains ($id | str lowercase)
}

def ps-quote [p: string] {
    "'" + ($p | str replace --all "'" "''") + "'"
}

def ensure-link [target: string, source: string] {
    let target = ($target | path expand)
    let source = ($source | path expand)

    if not ($source | path exists) {
        print $"    source missing, skipping: ($source)"
        return
    }

    let current = try {
        powershell -NoProfile -Command $"((Get-Item (ps-quote $target) -ErrorAction SilentlyContinue).Target)" | str trim
    } catch { "" }
    if ($current | str lowercase) == ($source | str lowercase) {
        print $"    already linked: ($target)"
        return
    }

    # Move anything in the way aside (rename, never delete).
    if ($target | path exists) {
        let backup = $"($target).bak"
        print $"    backing up ($target) -> ($backup)"
        mv $target $backup
    }
    mkdir ($target | path dirname)
    powershell -NoProfile -Command $"New-Item -ItemType SymbolicLink -Path (ps-quote $target) -Target (ps-quote $source) -Force | Out-Null"
    print $"    linked ($target) -> ($source)"
}

def makeSymbolicLinks [] {
    $links | each { |link|
        try {
            ensure-link $link.target $link.source
            null
        } catch { |e|
            print $"    FAILED: ($link.target): ($e.msg)"
            $link.target
        }
    } | compact
}

def ensureUserPath [dir: string] {
    let dir = ($dir | path expand)
    let on_path = (powershell -NoProfile -Command "[Environment]::GetEnvironmentVariable('Path','User')" | str trim | split row ";" | each { str lowercase } | any { $in == ($dir | str lowercase) })
    if $on_path {
        print $"    already on user PATH: ($dir)"
        return []
    }
    print $"==> Adding ($dir) to user PATH..."
    try {
        powershell -NoProfile -Command $"[Environment]::SetEnvironmentVariable('Path', ([Environment]::GetEnvironmentVariable('Path','User').TrimEnd(';') + ';' + (ps-quote $dir)), 'User')"
        []
    } catch { |e|
        print $"    FAILED: user PATH: ($e.msg)"
        ["user PATH"]
    }
}

def installVirtualDesktopAccessor [] {
    # Pinned release; check https://github.com/Ciantic/VirtualDesktopAccessor/releases for newer.
    # Single copy in Documents: Startup executes every file in it, so a DLL there
    # would pop an "Open with" dialog on every login.
    let url = "https://github.com/Ciantic/VirtualDesktopAccessor/releases/download/2024-12-16-windows11/VirtualDesktopAccessor.dll"
    let dests = [
        ($env.USERPROFILE | path join "Documents" "VirtualDesktopAccessor.dll")
    ]

    $dests | each { |dll|
        if ($dll | path exists) {
            print $"==> VirtualDesktopAccessor.dll already present, skipping: ($dll)"
            null
        } else {
            print $"==> Downloading VirtualDesktopAccessor.dll to ($dll)..."
            try {
                mkdir ($dll | path dirname)
                http get $url | save --force $dll
                null
            } catch { |e|
                print $"    FAILED: ($dll): ($e.msg)"
                $dll
            }
        }
    } | compact
}

def installHerdr [] {
    # No winget package exists; use the official installer.
    if (which herdr | is-not-empty) {
        print "==> herdr already installed, skipping."
        return []
    }
    print "==> Installing herdr [official installer]..."
    try {
        powershell -NoProfile -ExecutionPolicy Bypass -c "irm https://herdr.dev/install.ps1 | iex"
        []
    } catch { |e|
        print $"    FAILED: herdr: ($e.msg)"
        ["herdr (https://herdr.dev/install.ps1)"]
    }
}

def is-admin [] {
    (powershell -NoProfile -Command "([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)" | str trim) == "True"
}

def main [] {
    if (which winget | is-empty) {
        error make {msg: "winget not found. Install App Installer from the Microsoft Store first."}
    }

    if not (is-admin) {
        error make {msg: "this terminal is not elevated. Creating symbolic links requires Administrator rights or Developer Mode (Settings > System > For developers). Restart the terminal as Administrator or enable Developer Mode, then rerun."}
    }

    let failed_pkgs = ($packages | each { |pkg|
        if (already-installed $pkg.id) {
            print $"==> ($pkg.name) already installed, skipping."
            null
        } else {
            print $"==> Installing ($pkg.name) [($pkg.id)]..."
            try {
                winget install --exact --id $pkg.id --source winget --silent --accept-package-agreements --accept-source-agreements
                null
            } catch {
                if (already-installed $pkg.id) {
                    print $"    ($pkg.name) showed up during install, skipping."
                    null
                } else {
                    print $"    FAILED: ($pkg.name)"
                    $pkg.id
                }
            }
        }
    } | compact)

    mut failed = $failed_pkgs

    $failed = ($failed ++ (installHerdr))

    print "==> Creating symbolic links..."
    $failed = ($failed ++ (makeSymbolicLinks))

    $failed = ($failed ++ (ensureUserPath ($env.USERPROFILE | path join ".local" "bin")))

    $failed = ($failed ++ (installVirtualDesktopAccessor))

    if ($failed | is-not-empty) {
        print ""
        print $"Failed: ($failed | str join ', ')"
        exit 1
    }

    print ""
    print "Done. Restart your terminal so PATH changes take effect."
}
