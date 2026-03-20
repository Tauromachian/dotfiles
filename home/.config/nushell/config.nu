$env.config.edit_mode = 'vi'

def apt [...args] {
    nala ...$args
}

if (which tmux | is-not-empty) and ($env.TMUX? | is-empty) {
    tmux
}

# In ~/.config/nushell/env.nu
$env.HOMEBREW_PREFIX = "/home/linuxbrew/.linuxbrew"
$env.HOMEBREW_CELLAR = "/home/linuxbrew/.linuxbrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/home/linuxbrew/.linuxbrew"
$env.PATH = ($env.PATH | prepend [
    "/home/linuxbrew/.linuxbrew/bin"
    "/home/linuxbrew/.linuxbrew/sbin"
])
