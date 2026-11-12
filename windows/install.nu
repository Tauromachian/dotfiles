#!/usr/bin/env nu
# Windows workstation setup.
# Bootstrap nushell itself first (winget, or https://www.nushell.sh/book/installation.html),
# then run: nu install.nu
# NOTE: restart your terminal afterwards so PATH changes take effect.

# winget packages.
let packages = [
    { name: "fzf", id: "junegunn.fzf" }
    { name: "Neovim", id: "Neovim.Neovim" }
    { name: "Alacritty", id: "Alacritty.Alacritty" }
    { name: "Chromium", id: "Hibbiki.Chromium" }
    { name: "AutoHotkey v2", id: "AutoHotkey.AutoHotkey" }
    { name: "GNU Make", id: "GnuWin32.Make" }
]

def already-installed [id: string] {
    winget list --exact --id $id
    | complete
    | get stdout
    | str downcase
    | str contains ($id | str downcase)
}

def main [] {
    if (which winget | is-empty) {
        error make {msg: "winget not found. Install App Installer from the Microsoft Store first."}
    }

    mut failed = []

    for pkg in $packages {
        if (already-installed $pkg.id) {
            print $"==> ($pkg.name) already installed, skipping."
            continue
        }
        print $"==> Installing ($pkg.name) [($pkg.id)]..."
        try {
            winget install --exact --id $pkg.id --source winget --silent --accept-package-agreements --accept-source-agreements
        } catch {
            if (already-installed $pkg.id) {
                print $"    ($pkg.name) showed up during install, skipping."
            } else {
                print $"    FAILED: ($pkg.name)"
                $failed = ($failed | append $pkg.id)
            }
        }
    }

    if ($failed | is-not-empty) {
        print ""
        print $"Failed: ($failed | str join ', ')"
        exit 1
    }

    print ""
    print "Done. Restart your terminal so PATH changes take effect."
}
