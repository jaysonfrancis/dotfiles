# functions.zsh
 _user="$(id -u -n)"

function uvrun() {
    uv run $1
}

function ipof() {
  getent hosts "$1" | awk '{print $1}'
}

function ca() {
    pick_local_env() {
        local env
        env=$(\ls /local/$USER/venv 2>/dev/null | fzf --height 40% --border)
        [[ -n "$env" ]] && source "/local/$USER/venv/$env/bin/activate" || echo "No environment selected."
    }

    pick_conda_env() {
        local env
        env=$(conda env list | sed '1,3d; s/ .*$//' | fzf --height 40% --border)
        [[ -n "$env" ]] && conda activate "$env" || echo "No environment selected."
    }

    case "$1" in
        --conda)
            pick_conda_env
            ;;
        --all)
            # cycle: local → user venv → conda
            if [[ -d .venv ]]; then
                source .venv/bin/activate
            elif [[ -d venv ]]; then
                source venv/bin/activate
            elif [[ -d /local/$USER/venv ]]; then
                pick_local_env
            else
                pick_conda_env
            fi
            ;;
        "")
            # default: local → user venv → conda fallback
            if [[ -d .venv ]]; then
                source .venv/bin/activate
            elif [[ -d venv ]]; then
                source venv/bin/activate
            elif [[ -d /local/$USER/venv ]]; then
                pick_local_env
            else
                pick_conda_env
            fi
            ;;
        *)
            if [[ -d "/local/$USER/venv/$1" ]]; then
                source "/local/$USER/venv/$1/bin/activate"
            elif conda env list | grep -q "^$1 "; then
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
