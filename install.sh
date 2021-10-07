#!/bin/bash

# Color helpers.
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

# Logging helpers.
info() {
    echo -e "[${GREEN} INFO${RESET}]" "$@"
}
warn() {
    echo -e "[${YELLOW} WARN${RESET}]" "$@"
}
error() {
    echo -e "[${RED}ERROR${RESET}]" "$@"
}
fatal() {
    echo -e "[${RED}FATAL${RESET}]" "$@"
    exit 1
}

# Helper to download a file script.
if CURL=$(command -v curl); then
    download() {
        $CURL -fsL --proto-redir -all,https "$1"
    }
elif WGET=$(command -v wget); then
    download() {
        $WGET -q --https-only -O- "$1"
    }
else
    fatal "Could not find curl or wget on the system. Please install one of them"
fi

# Get value for DOTROOT.
if [ -z "$DOTROOT" ]; then
    if REALPATH=$(command -v realpath) && DIRNAME=$(command -v dirname); then
        dir=$($REALPATH $($DIRNAME $0))
    else
        dir="${0%/*}"
        dir="${dir##*/}"
        if [ "${dir%%/*}" ]; then
            dir=$PWD/$dir
        fi
    fi
    DOTROOT=$dir
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

# SpaceVim target for Vim.
install_spacevim() {
    if [ ! -d ~/.SpaceVim ]; then
        info "Installing SpaceVim"
        if download https://spacevim.org/install.sh | bash -s -- --install; then
            info "SpaceVim installed"
        else
            fatal "SpaceVim could not be installed"
        fi
    fi

    # ln -sf ${DOTROOT/\~/$HOME}/nvim ~/.SpaceVim.d
    # info "SpaceVim user config linked"
}

# LunarVim target for NeoVim.
install_lunarvim() {
    if [ ! -d ~/.local/share/lunarvim ]; then
        info "Installing LunarVim"
        if bash <(download https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) --no-install-dependencies; then
            info "LunarVim installed"
        else
            fatal "LunarVim could not be installed"
        fi
    fi

    ln -sf ${DOTROOT/\~/$HOME}/lvim ~/.config/lvim
    info "LunarVim user config linked"
}

# Zsh target.
install_zsh() {
    # info "Installing Zsh configuration..."
    if [ ! -d ~/.zplug ]; then
        info "Installing Zplug"
        if download https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh; then
            info "Zplug installed"
        else
            fatal "Zplug could not be installed"
        fi
    fi
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
    install_lunarvim
    install_spacevim
    install_zsh
    install_tmux
    exit
fi

# Install given targets only.
while [[ $# -gt 0 ]]; do
    TARGET=$(echo "$1" | tr "[:upper:]" "[:lower:]")
    shift
    case "$TARGET" in
        nvim|neovim)
            install_lunarvim
            ;;
        vim)
            install_spacevim
            ;;
        zsh)
            install_zsh
            ;;
        tmux)
            install_tmux
            ;;
    esac
done
