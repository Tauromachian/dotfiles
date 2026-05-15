# ~/.config/fish/config.fish

# Source personal dotfiles (equivalent to `use`)
# Fish uses `source` instead of `use` - adjust path as needed
source ~/.dotfiles/dotfiles-personal/hasten-ey.fish

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

# apt → nala wrapper (fish function equivalent of nushell `def`)
function apt
    nala $argv
end

# Auto-start tmux if available and not already inside a session
if command -q tmux; and not set -q TMUX
    tmux
end

# Editor
set -gx EDITOR "nvim --noplugin"

# Fish vi mode (equivalent of edit_mode = 'vi')
fish_vi_key_bindings

# Homebrew (Linuxbrew)
set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew"
fish_add_path /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin

# Starship prompt
set -gx STARSHIP_SHELL fish
starship init fish | source

# fnm (Fast Node Manager)
set fnm_path "$HOME/.local/share/fnm"
if test -d $fnm_path
    fish_add_path $fnm_path
    fnm env --shell fish | source
end
