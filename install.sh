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
    dir=$($REALPATH "$($DIRNAME "$0")")
  else
    dir="${0%/*}"
    dir="${dir##*/}"
    if [ "${dir%%/*}" ]; then
      dir=$PWD/$dir
    fi
  fi
fi
DOTROOT=${dir/$HOME/\~}

# Add a line to a file if it is not already there
add_line() {
  local file="$1"
  local line="$2"
  if ! grep "$line" "$file" >/dev/null 2>&1; then
    echo "$line" >>"$file"
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
}

# LazyVim target for NeoVim.
install_lazyvim() {
  ln -sf "${DOTROOT/\~/$HOME}/lazyvim" ~/.config/nvim
  info "LazyVim user config linked"
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

# Ghostty target.
install_ghostty() {
  ln -sf "${DOTROOT/\~/$HOME}/ghostty" ~/.config/ghostty
  info "Ghostty user config linked"
}

# Install the catppuccin-macchiato theme for the GitUI TUI.
install_gitui() {
  theme_url="https://raw.githubusercontent.com/catppuccin/gitui/refs/heads/main/themes/catppuccin-macchiato.ron"
  gitui_cfg_dir="${XDG_CONFIG_HOME:-$HOME/.config}/gitui"
  mkdir -p "$gitui_cfg_dir"
  curl -fsSL "$theme_url" -o "$gitui_cfg_dir/theme.ron"
}

# If no targets were given then install all of them.
if [[ $# -eq 0 ]]; then
  install_lazyvim
  install_ghostty
  install_zsh
  install_tmux
  install_gitui
  exit
fi

# Install given targets only.
while [[ $# -gt 0 ]]; do
  target=$(echo "$1" | tr "[:upper:]" "[:lower:]")
  shift
  case "$target" in
  lazyvim)
    install_lazyvim
    ;;
  spacevim)
    install_spacevim
    ;;
  zsh)
    install_zsh
    ;;
  tmux)
    install_tmux
    ;;
  ghostty)
    install_ghostty
    ;;
  gitui)
    install_gitui
    ;;
  esac
done
