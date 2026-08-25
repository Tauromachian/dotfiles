source ~/.config/fish/hasten-ey.fish

# Aliases
alias v='nvim'
alias docker='podman'
alias docker-compose='podman-compose'
alias nr='npm run'
alias ni='corepack npm install'
alias y='corepack yarn'
alias pn='corepack pnpm'
alias ghost:start='ghost start --no-setup-linux-user'

alias php8.0='podman run --rm -v "$PWD:/var/www/html" --network host -p 8000:8000 localhost/php8.0 php'
alias composer='podman run --rm --network host -v "$PWD:/usr/src/myapp" -w /usr/src/myapp php:dev-env composer'
alias art='php artisan'
alias art:serve='podman run --rm --network host --interactive --tty -v "$PWD:/usr/src/myapp" -w /usr/src/myapp -p 8000:8000 php:dev-env php artisan serve --host 0.0.0.0 --port 8000'

alias ls='eza --long --header --icons'

# apt → nala wrapper
function apt
    nala $argv
end

function sudo
    if test "$argv[1]" = "apt"
        command sudo nala $argv[2..]
    else
        command sudo $argv
    end
end
funcsave sudo

# Auto-start tmux if available and not already inside a session
if command -q tmux; and not set -q TMUX
    tmux
end

# Editor
set -gx EDITOR "nvim --noplugin"

# Fish vi mode
fish_vi_key_bindings

# Homebrew (Linuxbrew)
set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew"
fish_add_path /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin

# Starship prompt
set -gx STARSHIP_SHELL fish
starship init fish | source

# opencode
fish_add_path /home/jose/.opencode/bin

if command -q workmux
    workmux completions fish | source
end

# pnpm
set -gx PNPM_HOME "/home/jose/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
