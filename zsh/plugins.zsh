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
