#!/bin/bash
LOCKFILE="/tmp/readtext.lock"

if [ -f "$LOCKFILE" ]; then
  kill "$(cat "$LOCKFILE")" 2>/dev/null
  pkill -P "$(cat "$LOCKFILE")" 2>/dev/null
  rm -f "$LOCKFILE"
  sleep 0.1
fi

echo $$ >"$LOCKFILE"
trap 'rm -f "$LOCKFILE"' EXIT

notify-send "Select region to read..."

SCR_IMG=$(mktemp -d) || {
  notify-send "Failed to create temp dir"
  exit 1
}
trap 'rm -rf "$SCR_IMG" "$LOCKFILE"' EXIT

hyprshot -m region -f scr.png --silent -o "$SCR_IMG"
sleep 0.1

if [ ! -f "$SCR_IMG/scr.png" ]; then
  notify-send "Screenshot cancelled"
  exit 1
fi

# Preprocess for better OCR
magick "$SCR_IMG/scr.png" -colorspace gray -resize 400% -sharpen 0x1 "$SCR_IMG/scr.png"

TEXT=$(tesseract "$SCR_IMG/scr.png" stdout --psm 6 --oem 3 2>/dev/null | tr -s ' \n' ' ')

if [ -z "$TEXT" ]; then
  notify-send "No text detected"
  exit 1
fi

notify-send "Speaking..."
echo "$TEXT" | gtts-cli -l en-GB - -o - 2>/dev/null | mpv --vo=null --no-audio-display --speed=1.4 - 2>/dev/null
