#!/usr/bin/env zsh

VIVID_COLORSCHEME="catppuccin-mocha"
VIVID_VERSION=0.10.1

arch=$(uname -m)
case $arch in
  i386) arch="386" ;;
  x86_64) arch="amd64" ;;
  arm | aarc64) arch="arm64" ;;
esac

VIVID_DEB=vivid_${VIVID_VERSION}_${arch}.deb
VIVID_URL=https://github.com/sharkdp/vivid/releases/download/v${VIVID_VERSION}/$VIVID_DEB

if ! which vivid >/dev/null; then
  curl -fL $VIVID_URL -o /tmp/$VIVID_DEB
  sudo dpkg -i /tmp/$VIVID_DEB
fi

export LS_COLORS="$(vivid generate $VIVID_COLORSCHEME)"
