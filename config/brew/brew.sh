# Install Homebrew

# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew upgrade

# Install packages

apps=(
    pipx
    fd
    ripgrep
    git
    ffmpeg
    cmake
    stylua
    grep
    isort
    black
    ruff     # Linter for Python
    luarocks # Lua package manager
    shfmt    # Shell script formatter
    wget
    bat                        # A cat clone with syntax highlighting
    fzf                        # Command-line fuzzy finder
    clang-format               # C/C++/Objective-C source code formatter
    tmux                       # Terminal multiplexer
    pylint                     # Python linter
    uv                         # Toolkit for developing with Ruff
    llm                        # Large Language Model tools
    zsh-syntax-highlighting    # Zsh plugin for syntax highlighting
    zsh-autosuggestions        # Zsh plugin for command autosuggestions
    zoxide                     # A smarter cd command
    eza                        # Modern replacement for 'ls'
    tlrc                       # Help utility
    diff-so-fancy              # Better git diff output
    neofetch                   # System information tool
    jq                         # JSON parser
    koekeishiya/formulae/skhd  # Key-binding daemon for macOS
    koekeishiya/formulae/yabai # Tiling window manager for macOS
    cloc                       # count lines of code
    sesh                       # tmux sesh manager
)

# Install fonts (requires --cask)
brew tap homebrew/cask-fonts
casks=(
    font-hack-nerd-font # Nerd font with programming ligatures
)

# Install applications
brew install "${apps[@]}"
brew install --cask "${casks[@]}"

# Git comes with diff-highlight, but isn't in the PATH
# ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" /usr/local/bin/diff-highlight

# NOTE: Insatlling bat theme
# mkdir -p "$(bat --config-dir)/themes"
# cd "$(bat --config-dir)/themes"
# # Replace _night in the lines below with _day, _moon, or _storm if needed.
# curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
# bat cache --build
# bat --list-themes | grep tokyo # should output "tokyonight_night"
# echo '--theme="tokyonight_night"' >> "$(bat --config-dir)/config"
