#!/usr/bin/env bash

choice=$(printf "pacman search\naur search\ninstalled pkgs" | rofi -dmenu -p "Run" -theme ~/.config/rofi/cmdrunner.rasi)
ret=$?
[ -z "$choice" ] && exit 0

case "$choice" in
  "pacman search")
    cmd="$HOME/.config/hypr/scripts/pacsearch.sh"
    ;;
  "aur search")
    cmd="$HOME/.config/hypr/scripts/aursearch.sh"
    ;;
  "installed pkgs")
    cmd="$HOME/.config/hypr/scripts/installed.sh"
    ;;
  *)
    cmd_first=$(echo "$choice" | awk '{print $1}')
    if command -v "$cmd_first" &>/dev/null; then
      cmd="$choice"
    else
      rofi -e "󰚩 unknown command: $cmd_first"
      exit 1
    fi
    ;;
esac

kitty --class kitty-cmdrunner -e bash -c "$cmd"
