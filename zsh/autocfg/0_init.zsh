# autocfg

# Ensure cache directory exists for performance optimizations
[[ ! -d "$ZSH/cache" ]] && mkdir -p "$ZSH/cache"

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
# Cache brew prefix for performance (avoid subprocess calls)
BREW_PREFIX="${BREW_PREFIX:-$(brew --prefix 2>/dev/null || echo '/opt/homebrew')}"
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#34bdeb,bold'

# --- cmd auto suggestions ---
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# --- tmx integration ----
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Zoxide (better cd) ----
# Cache zoxide init for performance
ZOXIDE_CACHE="$ZSH/cache/zoxide_init.zsh"
if [[ ! -f "$ZOXIDE_CACHE" ]] || [[ "$(which zoxide)" -nt "$ZOXIDE_CACHE" ]]; then
    zoxide init zsh > "$ZOXIDE_CACHE" 2>/dev/null
fi
[[ -f "$ZOXIDE_CACHE" ]] && source "$ZOXIDE_CACHE"
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


# --- terminal arrow keys ---
bindkey '[C' forward-word
bindkey '[D' backward-word

# --- clear screen alternative (since C-l is used by tmux navigator) ---
bindkey '^O' clear-screen        # C-o for clear screen
# Fallback: Use tmux prefix + C-l (` + C-l locally, ~ + C-l remotely)

# Enable menu-style tab completion
zstyle ':completion:*' menu select

# --- uv autocomplete ---
# Cache uv completion for performance
UV_CACHE="$ZSH/cache/uv_completion.zsh"
if [[ ! -f "$UV_CACHE" ]] || [[ "$(which uv)" -nt "$UV_CACHE" ]]; then
    uv generate-shell-completion zsh > "$UV_CACHE" 2>/dev/null
fi
[[ -f "$UV_CACHE" ]] && source "$UV_CACHE"

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
