$env.config.edit_mode = 'vi'

def apt [...args] {
    nala ...$args
}

if (which tmux | is-not-empty) and ($env.TMUX? | is-empty) {
    tmux
}
