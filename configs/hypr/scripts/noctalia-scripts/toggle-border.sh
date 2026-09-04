#!/usr/bin/env bash
# Cycle window border size: 0 -> 1 -> 2 -> 0 -> ...

CURRENT="$(hyprctl getoption general:border_size -j | grep -oE '"int": [0-9]+' | grep -oE '[0-9]+')"

case "$CURRENT" in
    0) hyprctl eval 'hl.config({ general = { border_size = 1 } })' ;;
    1) hyprctl eval 'hl.config({ general = { border_size = 2 } })' ;;
    *) hyprctl eval 'hl.config({ general = { border_size = 0 } })' ;;
esac
