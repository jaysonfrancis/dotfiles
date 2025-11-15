# aliases.zsh

alias LL="eza -1lF --icons=always --color --long --git -s modified --total-size -o"
alias l="eza --color -l --icons=always --no-user --no-permissions -s type -s modified --group-directories-first -o --time-style relative" # --git
alias ll="eza --color -l --icons=always --no-permissions -s type -s modified --all --group-directories-first -o --time-style relative" # --git
alias lt="eza -1T"
alias ls="ls -l"
alias rp="realpath" # get abs path

alias gp="git pull --rebase" # git up
alias gP="git push" #
alias gs="git status" # git st
alias gd="git diff"
alias ga="git add -u ."
alias gspush="git stash push"
alias gspull="git stash pop"

alias vim="nvim"
alias zz="vim ~/.zshrc"
alias python3="python"
alias py="ipython"
alias help="tldr"

# Shortcuts
alias gg="lazygit"
alias lzd="lazydocker"
alias k="kubectl"

alias dfh="df -H --output=source,fstype,size,used,avail,pcent,target"

# TODO: for iterm, fix for ghostty "tmux new-session -A -s main"
alias tmx="tmux -CC new -A -s main"
alias tmxa="tmux -CC attach -t main"
alias cat="bat"

# Edit files
alias as="nvim ~/.dotfiles/zsh/autocfg/aliases.zsh" # <this file>
alias v='nvim $(fzf --preview="bat --color=always {}")'

# Move to directories
alias gdrive="cd ~/Google\ Drive/My\ Drive/"
alias work="cd ~/work/"
alias pers="cd ~/personal/"
alias dev="cd ~/dev"

# Move and Edit
alias dots="cd ~/.dotfiles/; vim zsh/autocfg/0_init.zsh"
alias obs="cd ~/Obs; vim"

alias jup="jupyter lab --autoreload --no-browser . &!"

alias t1="open -na Ghostty --args --theme='Blue Matrix'"
