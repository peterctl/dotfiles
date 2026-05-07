#!/usr/bin/env zsh

autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

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
zplug "Aloxaf/fzf-tab"

# Install the plugins.
if ! zplug check; then
    if ! zplug install; then
        echo "[ERROR] Could not install zplug plugins. Please run 'zplug install' manually"
    fi
fi
zplug load

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
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
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

source $ZSHROOT/vivid.zsh
source $ZSHROOT/starship.zsh
source $ZSHROOT/environment.zsh
source $ZSHROOT/autocomplete.zsh
