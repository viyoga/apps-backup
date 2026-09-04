#!/usr/bin/env bash
result=$(yay -Sl | awk '$1 == "aur" {print $2}' | fzf --preview="yay -Si {}" --preview-window="right:71%" \
  --expect="ctrl-i,ctrl-r" \
  --bind="alt-j:down,alt-k:up,alt-h:preview-up,alt-l:preview-down" \
  --prompt="Search AUR > ")
key=$(echo "$result" | sed -n "1p")
pkg=$(echo "$result" | sed -n "2p")
if [[ -n "$pkg" ]]; then
  case "$key" in
    ctrl-i) yay -S "$pkg" ;;
    ctrl-r) yay -Rns "$pkg" ;;
  esac
fi
