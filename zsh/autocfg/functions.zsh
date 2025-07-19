# functions.zsh
 _user="$(id -u -n)"

function uvrun() {
    uv run $1
}

# function rg(){
#     # path to optional config
#     local file="$HOME/.dotfiles/config/ghostty/remote_config"
#     local file_off="${file}_off"
#     # rename file on/off 
#     [ -f "$file" ] && mv "$file" "$file_off" || mv "$file_off" "$file"
#     # mac: trigger reload_config
#     osascript -e 'tell application "System Events" to keystroke "," using {command down, shift down}'
# }

function ca() {
    pick_conda_env() {
        local env
        env=$(conda env list | sed '1,3d; s/ .*$//' | fzf --height 40% --border)
        [[ -n "$env" ]] && conda activate "$env" || echo "No environment selected."
    }

    case "$1" in
        --all)
            pick_conda_env
            ;;
        "")
            if [[ -d .venv ]]; then
                source .venv/bin/activate
            elif [[ -d venv ]]; then
                source venv/bin/activate
            else
                pick_conda_env
            fi
            ;;
        *)
            if conda env list | grep -q "^$1 "; then
                conda activate "$1"
            else
                echo "Environment '$1' not found."
                return 1
            fi
            ;;
    esac
}

function da() {
    if [[ "$CONDA_DEFAULT_ENV" != "" ]]; then
        conda deactivate # If conda env is active
    elif [[ "$VIRTUAL_ENV" != "" ]]; then
        deactivate 
    else
        echo "No virtual environment is active."
    fi
}

# C-z for background/foreground processes
fancy-ctrl-z() {
    if [[ $#BUFFER -eq 0 ]]; then
        fg &>/dev/null
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
