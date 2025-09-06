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

# Use per-host history and compdump locations
export HISTFILE="$ZSH/cache/zsh_history_$HOST"

# Prevent history sharing/overwrite conflicts
unsetopt share_history         # Prevent sharing history across terminals
unsetopt inc_append_history    # Don’t auto-write after every command

# HISTORY
# setopt append_history          # Append on shell exit (not overwrite)
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
# setopt SHARE_HISTORY             # Share history between all sessions.


# --- terminall arrow keys ---
bindkey '[C' forward-word
bindkey '[D' backward-word

# Enable menu-style tab completion
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

# Add maxtex
export PATH="/usr/local/texlive/2025/bin/universal-darwin:$PATH"

# # Disable auto-setting terminal title. (ghostty)
# DISABLE_AUTO_TITLE="true"
# function precmd () {
#   echo -ne "\033]0;Custom title: $(print -rD $PWD)\007"
# }
# precmd
#
# function preexec () {
#   print -Pn "\e]0;🚀 $(print -rD $PWD) $1 🚀\a"
# }

# End
