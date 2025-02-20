# autocfg

OS=$(uname)
HOST=$(hostname -s)
EDITOR="nvim"
USER=$(whoami)

if [[ $TERM == "xterm-ghostty" ]]; then
    true

elif [[ $TERM == "xterm-256color" ]]; then
  if [[ -n $SSH_CONNECTION ]]; then
    echo -e "\033]50;SetProfile=remote\a"
  else
    echo -e "\033]50;SetProfile=local\a"
  fi
fi

source ~/.dotfiles/private/private_init.zsh

# --- cmd highlighting ---
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#34bdeb,bold'

# --- cmd auto suggestions ---
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- tmx integration ----
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- individual history per tab ----
unsetopt inc_append_history
unsetopt share_history
setopt noincappendhistory
setopt nosharehistory

# --- terminall arrow keys ---
bindkey '[C' forward-word
bindkey '[D' backward-word

# --- added by typer --auto-complete ---
fpath+=~/.zfunc; autoload -Uz compinit; compinit
zstyle ':completion:*' menu select

# --- uv autocomplete ---
eval "$(uv generate-shell-completion zsh)"

# --- enable tab complete with 'uv run' ---
_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv

# --- activate rust ---
. "$HOME/.cargo/env" 


# End
