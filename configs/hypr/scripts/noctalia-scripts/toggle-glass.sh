#!/usr/bin/env bash
# Toggle window glass: transparent+blur <-> opaque+no-blur
# Also keeps noctalia transparency_mode + bar opacity in sync:
#   soft (glassy) <-> solid (opaque)

STATE_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/noctalia-scripts/glass"
SETTINGS="$HOME/.local/state/noctalia/settings.toml"
CONFIG="$HOME/.config/noctalia/config.toml"

if [[ -f "$STATE_FILE" ]]; then
    # currently glassy -> make opaque
    rm -f "$STATE_FILE"
    hyprctl eval 'hl.config({ decoration = { active_opacity = 1, inactive_opacity = 1, blur = { enabled = false } } })'
    sed -i 's/transparency_mode = ".*"/transparency_mode = "solid"/' "$CONFIG"
    sed -i '/^[[:space:]]*transparency_mode = /d' "$SETTINGS"
    sed -i '0,/background_opacity = [0-9.e+-]*/s//background_opacity = 1.0/' "$SETTINGS"
else
    # currently opaque -> make glassy
    mkdir -p "$(dirname "$STATE_FILE")"
    touch "$STATE_FILE"
    hyprctl eval 'hl.config({ decoration = { active_opacity = 0.78, inactive_opacity = 0.88, blur = { enabled = true } } })'
    sed -i 's/transparency_mode = ".*"/transparency_mode = "soft"/' "$CONFIG"
    sed -i '/^[[:space:]]*transparency_mode = /d' "$SETTINGS"
    sed -i '0,/background_opacity = [0-9.e+-]*/s//background_opacity = 0.7/' "$SETTINGS"
fi

noctalia msg config-reload
