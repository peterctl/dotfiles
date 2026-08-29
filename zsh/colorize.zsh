#!/usr/bin/env zsh

ZSH_COLORIZE_TOOL=chroma
ZSH_COLORIZE_STYLE=$COLORSCHEME

if [[ "$TERM" =~ "256color" ]]; then
  ZSH_COLORIZE_CHROMA_FORMATTER=terminal256
fi

CHROMA_VERSION=2.27.0
CHROMA_TGZ="chroma-${CHROMA_VERSION}-${MACHINE}-${ARCH}.tar.gz"
CHROMA_URL="https://github.com/alecthomas/chroma/releases/download/v${CHROMA_VERSION}/${CHROMA_TGZ}"

if ! which chroma >/dev/null; then
  curl -fL $CHROMA_URL | tar -xz -C $HOME/.local/bin/ chroma
fi

alias cat=ccat
alias less=cless
