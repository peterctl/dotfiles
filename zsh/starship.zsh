#!/usr/bin/env zsh

if ! which starship >/dev/null; then
  echo "Installing Starship prompt."
  curl -sS https://starship.rs/install.sh | sh
fi

eval "$(starship init zsh)"
