# Load keybindings from inputrc files.

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
        eval "$(sed -e "$TESTS" $(for s in $SOURCES; do test -f $s && echo -e '$s '; done))"
    fi
}

__load_keybindings_from_inputrc
