#!/usr/bin/env bash
result=$(
  {
    pacman -Qqen | while read -r pkg; do
      printf "%-40s [official]\n" "$pkg"
    done
    pacman -Qqem | while read -r pkg; do
      printf "%-40s [aur]\n" "$pkg"
    done
  } | sort -f | fzf --preview="pacman -Qi {1}" --preview-window="right:71%" \
    --expect="ctrl-i,ctrl-r" \
    --bind="alt-j:down,alt-k:up,alt-h:preview-up,alt-l:preview-down" \
    --prompt="Installed packages > "
)
key=$(echo "$result" | sed -n "1p")
pkg=$(echo "$result" | awk '{print $1}' | sed -n "2p")
if [[ -n "$pkg" ]]; then
  case "$key" in
    ctrl-i) yay -S "$pkg" ;;
    ctrl-r) sudo pacman -Rns "$pkg" ;;
  esac
fi