#!/usr/bin/env zsh

# Emulate bash's _have function
function _have () {
    type $1 &> /dev/null
}

# Detect running OS.
case "$(uname -s)" in
    Linux*)  machine="linux";;
    Darwin*) machine="macos";;
    CYGWIN*) machine="cygwin";;
    MINGW*)  machine="mingw";;
    *)       machine="unknown";;
esac

# Detect running architecture.
arch=$(uname -m)
case $arch in
  i386) arch="386";;
  x86_64) arch="amd64";;
  arm | aarc64) arch="arm64";;
esac

# Directory containing current file.
ZSHROOT=${0:a:h}

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

source $ZSHROOT/plugins.zsh
source $ZSHROOT/keybindings.zsh
source $ZSHROOT/aliases.zsh
source $ZSHROOT/vivid.zsh
source $ZSHROOT/starship.zsh
source $ZSHROOT/environment.zsh
source $ZSHROOT/autocomplete.zsh
