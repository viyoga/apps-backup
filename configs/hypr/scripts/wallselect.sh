#!/bin/bash
# ~/.config/hypr/scripts/wallselect.sh
# Theme-aware wallpaper picker — Ctrl+Super+Space

THEMES_DIR="$HOME/.config/themes"
ACTIVE_FILE="$THEMES_DIR/themes.conf"

ACTIVE_THEME=$(cat "$ACTIVE_FILE" 2>/dev/null)
WALL_DIR="$THEMES_DIR/$ACTIVE_THEME/wallpapers"

[[ ! -d "$WALL_DIR" ]] && exit 1

WALL=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) |
  while read -r f; do
    echo -en "$(basename "$f")\x00icon\x1f$f\n"
  done |
  rofi -dmenu -p "Wallpapers" -show-icons -i -theme ~/.config/rofi/wallpaper-switcher.rasi)

[[ -z "$WALL" ]] && exit 0

FULL_PATH="$WALL_DIR/$WALL"
[[ ! -f "$FULL_PATH" ]] && exit 1

cp "$FULL_PATH" "$HOME/.config/hypr/current-wall.png"
awww img "$FULL_PATH" --transition-type simple --transition-step 2 --transition-fps 60 --transition-duration 1
