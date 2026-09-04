#!/bin/bash
active=$(hyprctl activewindow -j)
floating=$(echo "$active" | jq -r '.floating')
class=$(echo "$active" | jq -r '.class')

if [ "$floating" = "false" ]; then
  hyprctl dispatch 'hl.dsp.window.float({action = "toggle"})'
  sleep 0.05
  case "$class" in
    org.gnome.Nautilus|nautilus)
      hyprctl dispatch "hl.dsp.window.resize({x = 855, y = 585})"
      ;;
    helium)
      hyprctl dispatch "hl.dsp.window.resize({x = 1568, y = 900})"
      ;;
    *)
      read -r w h <<<$(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.width) \(.height)"')
      hyprctl dispatch "hl.dsp.window.resize({x = $((w * 70 / 100)), y = $((h * 72 / 100))})"
      ;;
  esac
  hyprctl dispatch 'hl.dsp.window.center()'
else
  hyprctl dispatch 'hl.dsp.window.float({action = "toggle"})'
fi
