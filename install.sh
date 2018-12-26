#!/bin/bash

ROOT=$(realpath $(dirname $0))
ROOT=${ROOT/$HOME/\~}

# Add a line to a file if it is not already there
add_line() {
    local file="$1"
    local line="$2" 
    if ! grep "$line" "$file" > /dev/null 2>&1 ; then
        echo "$line" >> "$file"
        return 0
    fi
    return 1
}

# Color helpers.
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

# Logging helpers.
info() {
    echo -e "[${GREEN} INFO${RESET}] $@"
}
warn() {
    echo -e "[${YELLOW} WARN${RESET}] $@"
}
error() {
    echo -e "[${RED}ERROR${RESET}] $@"
}

# NeoVim target.
install_nvim() {
    info "Installing NeoVim configuration..."
    if ! add_line ~/.config/nvim/init.vim "source $ROOT/nvim/init.vim"; then
        warn "NeoVim's RC was already configured."
    fi
    if ! add_line ~/.vimrc "source $ROOT/nvim/init.vim"; then
        warn "Vim's RC was already configured."
    fi
}

# Zsh target.
install_zsh() {
    info "Installing Zsh configuration..."
    if ! add_line ~/.zshrc "source $ROOT/zsh/init.zsh"; then
        warn "Zsh's RC was already configured."
    fi
}

# Tmux target.
install_tmux() {
    warn "Tmux is not yet added."
}

# If no targets were given then install all of them.
if [[ $# -eq 0 ]]; then
    install_nvim
    install_zsh
    install_tmux
    exit
fi

# Install given targets only.
while [[ $# -gt 0 ]]; do
    TARGET=$(echo "$1" | tr "[:upper:]" "[:lower:]")
    shift
    case "$TARGET" in
        nvim|vim|neovim)
            install_nvim
            ;;
        zsh)
            install_zsh
            ;;
        tmux)
            install_tmux
            ;;
    esac
done
