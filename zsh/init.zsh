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

# Plugins
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "marlonrichert/zsh-edit"
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

if ! zplug check; then
    if ! zplug install; then
        echo "[ERROR] Could not install zplug plugins. Please run 'zplug install' manually"
    fi
fi
zplug load

# Settings for the spaceship theme.
export SPACESHIP_CHAR_SYMBOL="$ "
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
# __load_keybindings_from_inputrc

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

setopt extendedglob

# Add GOPATH to PATH
GOPATH=~/go
GOBIN=$GOPATH/bin
PATH=$GOBIN:$PATH

if ! ( echo $PATH | grep ~/.local/bin ) >/dev/null; then
  PATH=~/.local/bin:$PATH
fi

# Setup command completions
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
which kubectl >/dev/null && source <(kubectl completion zsh)
which juju >/dev/null && source /usr/share/bash-completion/completions/juju
which fasd >/dev/null && eval "$(fasd --init auto)"
if [ -d /usr/share/fzf ]; then
  source /usr/share/fzf/completion.zsh
  source /usr/share/fzf/key-bindings.zsh
fi
