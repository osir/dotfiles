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
kitty -d /tmp man $chosen

