#!/usr/bin/env bash
# blur-lab.sh — apply one Hyprland blur param live for tasting (Noctalia /blur lab)
# Usage: blur-lab.sh "size 12" | "passes 4" | ... | reset
# Runtime-only (hl.config merge) — looknfeel.lua is untouched; reset restores its values.
set -u

sel="${1:-}"

if [ "$sel" = "reset" ]; then
  hyprctl eval 'hl.config({ decoration = { blur = { size = 8, passes = 3, noise = 0.02, contrast = 1.1, brightness = 0.9, vibrancy = 0.1696 } } })' >/dev/null
  noctalia msg notification-show "Blur Lab" "reset to looknfeel defaults" 2>/dev/null || true
  echo "reset ok"
  exit 0
fi

key="${sel%% *}"
val="${sel#* }"
case "$key" in
  size|passes|noise|contrast|brightness|vibrancy) ;;
  *) echo "unknown param: $sel" >&2; exit 1 ;;
esac
if ! [[ "$val" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
  echo "non-numeric value: $val" >&2; exit 1
fi

hyprctl eval "hl.config({ decoration = { blur = { $key = $val } } })" >/dev/null
noctalia msg notification-show "Blur Lab" "$key = $val" 2>/dev/null || true
echo "$key = $val applied"
