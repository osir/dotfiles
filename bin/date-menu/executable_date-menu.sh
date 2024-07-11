#!/usr/bin/env bash

declare -a lines
while IFS= read -r line
do
    [[ "$line" != *\;* || "$line" == \#* ]] && continue

    name="${line%%;*}"
    cmd="${line#*;}"
    res="$( eval "$cmd" )"
    lines+=( "$name; $res" )
done < ~/bin/date-menu/dates.csv

chosen=$(
    printf '%s\n' "${lines[@]}" \
        | rofi -dmenu -p copy -i
)

[ "$chosen" != '' ] || exit 0
dt="${chosen#*; }"

printf '%s' "$dt" | wl-copy --primary
printf '%s' "$dt" | wl-copy
printf '%s' "$dt"
notify-send \
    --urgency  low \
    --icon     '/usr/share/icons/Papirus-Dark/22x22/actions/edit-copy.svg' \
    --app-name 'Unicode Menu' \
    'Unicode Menu' \
    "'$dt' copied to clipboard."

