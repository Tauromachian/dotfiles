alias v = nvim

$env.config.edit_mode = 'vi'

$env.STARSHIP_SHELL = "nu"
def create_left_prompt [] {
    if (which starship | is-not-empty) {
        starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
    } else {
        $"(pwd) "
    }
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# fnm lives under ~/.local/share/fnm on Unix but %APPDATA%/fnm by default on
# Windows. $env.HOME is often unset on Windows, so expand `~` instead.
let fnm_path = if ("~/.local/share/fnm" | path expand | path exists) {
    "~/.local/share/fnm" | path expand
} else if ("APPDATA" in $env) and ($env.APPDATA | path join "fnm" | path exists) {
    $env.APPDATA | path join "fnm"
} else {
    null
}

if $fnm_path != null {
    $env.PATH = ($env.PATH | prepend $fnm_path)
    ^fnm env --shell bash | lines | where $it starts-with export | parse 'export {key}="{value}"' | where key != PATH | transpose -r -d | load-env
    $env.PATH = ($env.PATH | prepend ($env.FNM_MULTISHELL_PATH))
}
