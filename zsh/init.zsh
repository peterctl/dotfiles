# Directory containing current file.
ROOT=${0:a:h}

# Plugins
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug load

# Spaceship theme configuration.
source $ROOT/spaceship.zsh

# Load inputrc to correctly setup special keys.
source $ROOT/inputrc.zsh

# Source alias definitions.
source $ROOT/alias.zsh

# Bind keys for history substring search in regular mode.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# History configuration.
HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=$HISTSIZE
setopt appendhistory extendedglob

# Add GOPATH to PATH
GOPATH=~/go
GOBIN=$GOPATH/bin
PATH=$GOBIN:$PATH
