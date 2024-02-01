#!/bin/sh

F='/tmp/cursor-autohide'
TIMEOUT_MS=1000

is_enabled() {
    grep -qs 'true' "$F"
    return $?
}

toggle_on() {
    echo 'true' > "$F"
    swaymsg seat '*' hide_cursor "$TIMEOUT_MS"
}

toggle_off() {
    echo 'false' > "$F"
    swaymsg seat '*' hide_cursor 0
}

if [ -z "$1" ]
then
    >&2 echo "Usage: $0 <is-enabled|toggle|enable|disable>"
    exit 1
fi

[ ! -f "$F" ] && touch "$F"

set -u

case "$1" in
    'is-enabled')
        if is_enabled
        then
            echo ''
        else
            echo ''
        fi
        ;;
    'toggle')
        if is_enabled
        then
            toggle_off
        else
            toggle_on
        fi
        ;;
    'enable')
        toggle_on
        ;;
    'disable')
        toggle_off
        ;;
    *)
        >&2 echo "Unknown arg 1: $1"
        exit 1;
esac

