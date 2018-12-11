#!/bin/bash

ROOT="$1"

if [ -z "$ROOT" ]; then
    ROOT=$(dirname $0)
fi

ROOT=$(realpath $ROOT)
ROOT=${ROOT/$HOME/\~}

install_nvim() {
    echo "Installing NeoVim configuration..."
    echo "source $ROOT/nvim/init.vim" >> ~/.config/nvim/init.vim
    echo "source $ROOT/nvim/init.vim" >> ~/.vimrc
}

install_nvim
