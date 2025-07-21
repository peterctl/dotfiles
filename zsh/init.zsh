#!/usr/bin/env zsh

# Configs.
USE_VIM_MODE=${USE_VIM_MODE:-false}

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

# Directory containing current file.
ZSHROOT=${0:a:h}

# Remove some chars from wordchars so that they're taken as word delimiters.
# WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # Original
WORDCHARS='*?[]~&;!#$%^(){}<>'

# Ensure ZPlug is installed.
export ZPLUG_HOME=~/.zplug
if ! test -f $ZPLUG_HOME/init.zsh; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

# Declare ZPlug plugins.
source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "marlonrichert/zsh-edit"
zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
if $USE_VIM_MODE; then
  zplug "spaceship-prompt/spaceship-vi-mode"
fi

# Install the plugins.
if ! zplug check; then
    if ! zplug install; then
        echo "[ERROR] Could not install zplug plugins. Please run 'zplug install' manually"
    fi
fi
zplug load

# Enable Vim mode.
if $USE_VIM_MODE; then
  eval spaceship_vi_mode_enable
  spaceship add --after line_sep vi_mode
fi

# Settings for the spaceship theme.
export SPACESHIP_CHAR_SYMBOL="$ "
export SPACESHIP_CHAR_SYMBOL_SUCCESS=$SPACESHIP_CHAR_SYMBOL
export SPACESHIP_CHARM_SYMBOL_FAILURE=$SPACESHIP_CHAR_SYMBOL
export SPACESHIP_CHAR_SYMBOL_ROOT="# "
export SPACESHIP_CHAR_SYMBOL_SECONDARY="> "
export SPACESHIP_EXIT_CODE_SHOW="true"
export SPACESHIP_EXIT_CODE_SYMBOL="!"
export SPACESHIP_JOBS_SYMBOL="\u231B"
export SPACESHIP_GIT_STATUS_DELETED="x"
if [[ "$machine" == "macos" ]]; then
    export SPACESHIP_DIR_LOCK_SYMBOL=" \U1F512"
fi

# Colorize output.
if [[ "$machine" == "macos" ]]; then
    export CLICOLOR=1
    lscmd='ls'
else
    lscmd='ls --color'
    alias grep='grep --color'
fi

# Alias definitions.
alias ls="$lscmd -Fh"
alias la='ls -A'
alias ll='ls -Al'
alias kc=kubectl
alias dk=docker
alias dkc=docker-compose
alias tf=terraform

# Load inputrc to correctly setup special keys.
function __load_keybindings_from_inputrc () {
    local SOURCES=(
        '/etc/inputrc'
        '~/.inputrc'
    )
    local TESTS=(
        '/^\"/! d;'
        's/^/bindkey -- /;'
        # 's/\\e/\x1B/;'
        's/\":/\"/;'
        's/history-search/history-beginning-search/'
    )

    local VALID_SOURCES=()
    for s in $SOURCES; do
        test -f $s && VALID_SOURCES+=($s)
    done

    if ! [ -z $VALID_SOURCES ]; then
        eval "$(sed -e "$TESTS" $VALID_SOURCES)"
    fi
}
__load_keybindings_from_inputrc

# Bind keys for history substring search in regular mode.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# History configuration.
HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=$HISTSIZE
setopt appendhistory

# Other options.
setopt extendedglob
setopt interactivecomments

# Add GOPATH to PATH
GOPATH=~/go
if [ -d $GOPATH ]; then
  GOBIN=$GOPATH/bin
  PATH=$GOBIN:$PATH
fi

if ! ( echo $PATH | grep ~/.local/bin ) >/dev/null; then
  PATH=~/.local/bin:$PATH
fi

# Setup command completions
maybe-source() { test -f $1 && source $1; }
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
which kubectl >/dev/null && source <(kubectl completion zsh)
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

# Setup preferred editor.
for editor in nvim vim vi; do
  if which $editor > /dev/null; then
    export EDITOR=$editor
    break
  fi
done
