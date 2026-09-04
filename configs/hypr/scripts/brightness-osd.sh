#!/bin/bash
step="${2:-10}"

if [ "$1" = "up" ]; then
    ddcutil setvcp 10 + "$step" >/dev/null 2>&1
elif [ "$1" = "down" ]; then
    ddcutil setvcp 10 - "$step" >/dev/null 2>&1
else
    exit 1
fi

read -r progress text <<< "$(ddcutil getvcp 10 2>/dev/null | awk -F'[=,]' '/current/{gsub(/ /,"",$2); gsub(/ /,"",$4); printf "%.2f %d%%", $2/$4, $2*100/$4}')"

swayosd-client --custom-progress "$progress" --custom-icon display-brightness-symbolic
