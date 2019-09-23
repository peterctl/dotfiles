#!/bin/bash

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

# Get value for DOTROOT.
if [ -z "$DOTROOT" ]; then
    if ! which realpath; then
        error "Root directory could not be inferred because realpath is not installed in your system"
        error "To fix this, either install realpath or set the environment variable DOTROOT"
        exit 1
    else
        : ${DOTROOT:=$(realpath $(dirname $0))}
    fi
fi
DOTROOT=${DOTROOT/$HOME/\~}

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

# NeoVim target.
install_nvim() {
    # info "Installing NeoVim configuration..."
    if add_line ~/.config/nvim/init.vim "source $DOTROOT/nvim/init.vim"; then
        info "NeoVim configuration added."
    else
        warn "NeoVim's RC was already configured."
    fi
    if add_line ~/.vimrc "source $DOTROOT/nvim/init.vim"; then
        info "Vim configuration added."
    else
        warn "Vim's RC was already configured."
    fi
}

# Zsh target.
install_zsh() {
    # info "Installing Zsh configuration..."
    if add_line ~/.zshrc "source $DOTROOT/zsh/init.zsh"; then
        info "Zsh configuration added."
    else
        warn "Zsh's RC was already configured."
    fi
}

# Tmux target.
install_tmux() {
    if add_line ~/.tmux.conf "source-file $DOTROOT/tmux/tmux.conf"; then
        info "Tmux configuration added."
    else
        warn "Tmux's RC was already configured."
    fi
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
