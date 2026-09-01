#!/usr/bin/env zsh

# Colorize output.
if [[ "$MACHINE" == "darwin" ]]; then
    export CLICOLOR=1
    lscmd='ls'
else
    lscmd='ls --color'
    alias grep='grep --color'
fi

alias ls="$lscmd -Fh"
alias la='ls -A'
alias ll='ls -Al'
alias kc=kubectl
alias dk=docker
alias dkc=docker-compose
alias tf=terraform
