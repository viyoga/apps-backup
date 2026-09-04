#!/usr/bin/env bash
result=$(pacman -Slq | fzf --preview="pacman -Si {}" --preview-window="right:71%" \
  --expect="ctrl-i,ctrl-r" \
  --bind="alt-j:down,alt-k:up,alt-h:preview-up,alt-l:preview-down" \
  --prompt="Search packages > ")
key=$(echo "$result" | sed -n "1p")
pkg=$(echo "$result" | sed -n "2p")
if [[ -n "$pkg" ]]; then
  case "$key" in
    ctrl-i) sudo pacman -S "$pkg" ;;
    ctrl-r) sudo pacman -Rns "$pkg" ;;
  esac
fi
