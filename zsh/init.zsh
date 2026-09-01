#!/usr/bin/env zsh

# Emulate bash's _have function
function _have () {
    type $1 &> /dev/null
}

# Detect running OS.
case "$(uname -s)" in
    Linux*)  MACHINE="linux";;
    Darwin*) MACHINE="darwin";;
    CYGWIN*) MACHINE="cygwin";;
    MINGW*)  MACHINE="mingw";;
    *)       MACHINE="unknown";;
esac

# Detect running architecture.
ARCH=$(uname -m)
case $ARCH in
  i386) ARCH="386";;
  x86_64) ARCH="amd64";;
  arm | aarc64) ARCH="arm64";;
esac

# Directory containing current file.
ZSHROOT="${0:a:h}"

# Remove some chars from wordchars so that they're taken as word delimiters.
# orig  = '*?_-.[]~=/&;!#$%^(){}<>' # Original
WORDCHARS='*?[]~&;!#$%^(){}<>'

# History configuration.
HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=$HISTSIZE
setopt appendhistory

# Other options.
setopt extendedglob
setopt interactivecomments

# Colorscheme.
COLORSCHEME="catppuccin-mocha"

source $ZSHROOT/environment.zsh
source $ZSHROOT/plugins.zsh
source $ZSHROOT/keybindings.zsh
source $ZSHROOT/aliases.zsh
source $ZSHROOT/colorize.zsh
source $ZSHROOT/vivid.zsh
source $ZSHROOT/starship.zsh
source $ZSHROOT/autocomplete.zsh
