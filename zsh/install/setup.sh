#!/bin/zsh

# Log
function print() {
    [ $# -eq 2 ] && echo -e "$1$2\033[0m" || echo "$1"
}

function install_brew() {
    [ ! -f "$(which brew)" ] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" ||
        brew update && print $SECONDARY "$(brew --version | head -1) is already installed."
}

function update_shell() {
    if [[ " $@ " =~ " --update-shell " ]]; then
        print $SECONDARY "Changing $SHELL to zsh"

        # Install the latest zsh shell
        brew install zsh

        # Chanage the default shell to zsh installed by Homebrew (macos may ship with
        # older version, therefore update the zsh)
        BREW_PREFIX=$(brew --prefix)
        if ! fgrep -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
            echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells
            chsh -s "${BREW_PREFIX}/bin/zsh"
        fi
    fi
}

function install_bins() {
    # Brew Binaries - these are binaries that are available as brew formula. A list
    # of these formulas are stored in the bins.txt file under ~/.config/brew/
    # ~ Note ~ : this file is automatically updates with everytime brew installs or
    # removes a binary
    bins=("$@")

    # required to properly install coreutils
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"

    # Install binaries using Homebrew, iterate over bins array and install.
    print $PRIMARY "Installing the following binaries $bins"
    for binary in "${bins[@]}"; do
        # split the brew formula into binary name and version of installation and
        # get the name of the binary (ex- php in php@7.4)
        b=$(echo $binary | cut -d \@ -f 1)
        # check if the binary is already present, otherwise install
        if ! brew list --formula | grep "$b" 1>/dev/null; then
            brew install "$binary"
        fi
    done
}

function install_casks() {
    # Brew Casks - these are the casks that are available as brew formula. A list
    # of these casks are stored in the casks.txt under ~/.config/brew folder.
    # ~ Note ~ : this file is automatically updates with everytime brew installs or
    # removes a casks
    casks=("$@")

    # required to properly install coreutils
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"

    print $PRIMARY "Installing the following casks $casks"

    # Install casks using Homebrew, iterate over casks array and install.
    for c in "${casks[@]}"; do
        [[ ! "$(brew list --cask | grep "$c")" ]] &&
            print $SECONDARY "Installing $c" && brew install --cask "$c"
    done

}

function install_yabai() {
    # TODO
}

function install_conda() {
    # curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
    # bash Miniforge3-$(uname)-$(uname -m).sh
}

function install_ohmyzsh() { 
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_uv() {
    # curl -LsSf https://astral.sh/uv/install.sh | sh
}
