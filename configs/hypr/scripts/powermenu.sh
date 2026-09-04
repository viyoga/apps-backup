#!/bin/bash
CHOSEN=$(printf "   Power Off\n   Reboot\n   Sign Out\n   Lock" |
    rofi -dmenu -p "Power" -i -theme ~/.config/rofi/power.rasi)

case "$CHOSEN" in
    *"Power Off") systemctl poweroff >/dev/null 2>&1 ;;
    *"Reboot")    systemctl reboot >/dev/null 2>&1 ;;
    *"Sign Out")  command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit ;;
    *"Lock")      pidof hyprlock || hyprlock ;;
esac
