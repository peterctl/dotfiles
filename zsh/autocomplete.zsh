#!/usr/bin/env zsh

CARAPACE_VERSION=1.6.4

arch=$(uname -m)
case $arch in
  i386) arch="386" ;;
  x86_64) arch="amd64" ;;
  arm | aarc64) arch="arm64" ;;
esac

PKG_NAME=carapace-bin_${CARAPACE_VERSION}_linux_${arch}.deb
CARAPACE_URL=https://github.com/carapace-sh/carapace-bin/releases/download/v${CARAPACE_VERSION}/$PKG_NAME

if ! which carapace >/dev/null; then
  curl -fL $CARAPACE_URL -o /tmp/$PKG_NAME
  sudo dpkg -i /tmp/$PKG_NAME
fi

# Setup command completions
maybe-source() { test -f $1 && source $1; }
which kubectl >/dev/null && source <(kubectl completion zsh)
which lxc >/dev/null && source <(lxc completion zsh)
which fasd >/dev/null && eval "$(fasd --init auto)"
maybe-source /etc/zsh_command_not_found
maybe-source /snap/juju/current/bash_completions/juju
maybe-source /snap/lxd/current/etc/bash_completion.d/snap.lxd.lxc
maybe-source /usr/share/bash-completion/completions/juju
maybe-source /usr/share/doc/fzf/examples/key-bindings.zsh
maybe-source /usr/share/doc/fzf/examples/completion.zsh
maybe-source /usr/share/fzf/completion.zsh
maybe-source /usr/share/fzf/key-bindings.zsh
maybe-source ~/.novarc

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*' menu select
# zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS} "ma=48;5;153;1"
source <(carapace _carapace)

if which fzf >/dev/null; then
  source <(fzf --zsh)
fi
