#!/bin/sh

chosen=$(grep -h -v '^#' ~/bin/unicode-menu/{favorites,emoji}.csv | rofi -dmenu -p copy -i -l 20)

[ "$chosen" != '' ] || exit 0

c=$(echo "$chosen" | sed 's/ .*$//')
printf "$c" | wl-copy --primary
printf "$c" | wl-copy
notify-send \
    --urgency  low \
    --icon     '/usr/share/icons/Papirus-Dark/22x22/actions/edit-copy.svg' \
    --app-name 'Unicode Menu' \
    'Unicode Menu' \
    "'$c' copied to clipboard."

