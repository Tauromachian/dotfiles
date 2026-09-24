### Added by Zinit's installer
# completions fpath must be set before compinit (triggered by zsh-autocomplete)
fpath=("$HOME/.local/share/zsh/site-functions" $fpath)
if [ -d "/home/linuxbrew/.linuxbrew/opt/asdf/share/zsh/site-functions" ]; then
  fpath=("/home/linuxbrew/.linuxbrew/opt/asdf/share/zsh/site-functions" $fpath)
fi
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    marlonrichert/zsh-autocomplete

### End of Zinit's installer chunk


# USER CONFIGURATION

PATH=$PATH:/home/jose/.yarn/bin:/home/jose/.config/.local/bin
export EDITOR="nvim --noplugin";

# Change cursor shape for vi modes (with tmux support)
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
       [[ $1 = 'block' ]]; then
        echo -ne '\e[2 q'  # block in normal mode
    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} == '' ]] ||
         [[ $1 = 'line' ]]; then
        echo -ne '\e[6 q'  # bar in insert mode
    fi
}
zle -N zle-keymap-select

# Apply on fresh line
function zle-line-init {
    zle -K viins  # default to insert
    echo -ne '\e[6 q'
}
zle -N zle-line-init

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if command -v tmux &> /dev/null && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux
fi

gcc_run() {
  command gcc $1 -o temp-file && ./temp-file && rm temp-file
}

apt() { 
  command nala "$@"
}

sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"

# opencode
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

# workmux - file-based completions (eval breaks with zsh-autocomplete, no compdef yet)
if command -v workmux &> /dev/null; then
  _workmux_site="$HOME/.local/share/zsh/site-functions/_workmux"
  if [[ ! -f "$_workmux_site" ]] || [[ "$(command -v workmux)" -nt "$_workmux_site" ]]; then
    mkdir -p "$HOME/.local/share/zsh/site-functions"
    workmux completions zsh > "$_workmux_site" 2>/dev/null
  fi
  unset _workmux_site
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# asdf (replaces fnm) - shims + completions, mirrors fish config
if [ -n "$ASDF_DATA_DIR" ]; then
  _asdf_shims="$ASDF_DATA_DIR/shims"
else
  _asdf_shims="$HOME/.asdf/shims"
fi
case ":$PATH:" in
  *":$_asdf_shims:"*) ;;
  *) export PATH="$_asdf_shims:$PATH" ;;
esac
unset _asdf_shims
