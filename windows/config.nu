alias v = nvim

# Attach to herdr on interactive shells only (scripts like install.nu load this
# config too). Skips when herdr is missing or already inside a herdr pane.
if $nu.is-interactive and (which herdr | is-not-empty) and ($env.HERDR_PANE_ID? | is-empty) {
    herdr
}

$env.config.edit_mode = 'vi'

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
