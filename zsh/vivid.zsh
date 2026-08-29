#!/usr/bin/env zsh

VIVID_COLORSCHEME="catppuccin-mocha"
VIVID_VERSION=0.10.1

VIVID_DEB=vivid_${VIVID_VERSION}_${arch}.deb
VIVID_URL=https://github.com/sharkdp/vivid/releases/download/v${VIVID_VERSION}/$VIVID_DEB

if ! which vivid >/dev/null; then
  curl -fL $VIVID_URL -o /tmp/$VIVID_DEB
  sudo dpkg -i /tmp/$VIVID_DEB
fi

export LS_COLORS="$(vivid generate $VIVID_COLORSCHEME)"
