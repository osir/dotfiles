#!/usr/bin/env bash

# Switches focus or moves a window to a namespace with a name picked via a menu.
# Names can be supplied as a comma separated list in arg2.
# Additionally, open workspaces (except 1-10) will be prepended.

action="${1:-switch}"
arg_workspaces=$(echo "${2:-}" | tr ',' '\n')

# Get currently open workspaces (except 1-10)
open_workspaces=$( \
    swaymsg -t get_workspaces \
        | jq '.[].name' \
        | grep -Pv '^"[0-9]+:' \
        | tr -d \"\
)

# Combine open and argument supplied workspaces and remove duplicates
workspaces=$( \
    echo -e "$open_workspaces\n$arg_workspaces" \
        | paste -d '\n' - - \
        | awk '!seen[$0]++'\
)
choice="$(echo "$workspaces" | rofi -dmenu -p "$action" -i)"

case "$action" in
    'switch')
        swaymsg workspace "$choice"
        ;;
    'move')
        swaymsg move workspace "$choice"
        ;;
    *)
        exit 1;
esac

