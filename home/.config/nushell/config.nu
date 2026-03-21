$env.config.edit_mode = 'vi'

let pwdRes = (pwd)

alias v = nvim

alias docker = podman
alias docker-compose = podman-compose

alias nr = npm run
alias ni = corepack npm install
alias y = corepack yarn
alias pn = corepack pnpm

alias ghost:start = ghost start --no-setup-linux-user

# php:dev-env stands for a custom php image build as a development environment 
alias php8.0 = podman run --rm -v $"$pwdRes:/var/www/html" --network host -p 8000:8000 localhost/php8.0 php
alias composer = podman run --rm --network host -v $"$pwdRes:/usr/src/myapp" -w /usr/src/myapp php:dev-env composer
alias art = php artisan
alias art:serve = podman run --rm --network host --interactive --tty -v $"$pwdRes:/usr/src/myapp" -w /usr/src/myapp -p 8000:8000 php:dev-env php artisan serve --host 0.0.0.0 --port 8000


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

$env.STARSHIP_SHELL = "nu"
def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

let fnm_path = $"($env.HOME)/.local/share/fnm"
if ($fnm_path | path exists) {
    $env.PATH = ($env.PATH | prepend $fnm_path)
    ^fnm env --shell bash | lines | where $it starts-with export | parse 'export {key}="{value}"' | where key != PATH | transpose -r -d | load-env
    $env.PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")
}
