#!/usr/bin/env bash
# Select a directory in rofi and open it in a terminal

declare -a lines
while IFS= read -r line
do
    if [[ "$line" != *\;* || "$line" == \#* ]]
    then
        continue
    fi
    name="${line%%;*}"
    path="${line#*;}"
    if [[ "$name" == '*' ]]
    then
        for subdir in "${path/#~/$HOME}"/*
        do
            if [[ -d "$subdir" ]]
            then
                lines+=( "${subdir##*/}; $subdir" )
            fi
        done
    else
        lines+=( "$name; $path" )
    fi
done < ~/bin/dir-menu/dirs.csv

chosen=$(
    printf '%s\n' "${lines[@]}" \
        | rofi -dmenu -p man -i -l 20
)

[ "$chosen" != '' ] || exit 0
path="${chosen#*; }"

kitty -d "${path/#~/$HOME}"

