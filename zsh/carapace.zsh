#!/usr/bin/env zsh

CARAPACE_VERSION=1.3.2

arch=$(uname -m)
case $arch in
  i386) arch="386" ;;
  x86_64) arch="amd64" ;;
  arm | aarc64) arch="arm64" ;;
esac

PKG_NAME=carapace-bin_${CARAPACE_VERSION}_linux_${arch}.deb
CARAPACE_URL=https://github.com/carapace-sh/carapace-bin/releases/download/v${CARAPACE_VERSION}/$PKG_NAME

if ! command carapace 2>/dev/null; then
  curl -fL $CARAPACE_URL -o /tmp/$PKG_NAME
  sudo dpkg -i /tmp/$PKG_NAME
fi

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*' menu select
# zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS} "ma=48;5;153;1"
source <(carapace _carapace)
