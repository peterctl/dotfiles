# Load keybindings from inputrc files.

function __load_keybindings_from_inputrc () {
    local TESTS=(
        '/^\"/! d;'
        's/^/bindkey -- /;'
        # 's/\\e/\x1B/;'
        's/\":/\"/;'
        's/history-search/history-beginning-search/'
    )
    eval "$(sed -e "$TESTS" /etc/inputrc $(test -f ~/.inputrc && echo ~/.inputrc))"
}

__load_keybindings_from_inputrc
