#!/usr/bin/env bash
# Select a man page in rofi and open it in a terminal

chosen=$(
    apropos . \
        | awk '{
            gsub(/\(|\)/, "", $2);
            print $2, $1;
        }' \
        | sort \
        | rofi -dmenu -p man -i -l 20
)

[ "$chosen" != '' ] || exit 0
   page="$( cut -d' ' -f 2 <<< "$chosen" )"
section="$( cut -d' ' -f 1 <<< "$chosen" )"

kitty --title "❓ man $page($section)" 'man' "$section" "$page"

