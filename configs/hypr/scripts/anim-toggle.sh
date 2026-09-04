#!/usr/bin/env bash
# anim-toggle.sh — toggle between slide and fade animation profiles
# Bound to SUPER + SHIFT + ;
# Uses animations.lua's apply_slide / apply_fade via hyprctl eval
# State persisted in ~/.cache/hypr-animations-mode

set -euo pipefail

STATE_FILE="$HOME/.cache/hypr-animations-mode"
CURRENT=$(cat "$STATE_FILE" 2>/dev/null || echo "slide")

if [ "$CURRENT" = "slide" ]; then
	TARGET="fade"
	FUNC="apply_fade"
	LABEL="FADE"
	DESC="window + workspace fade"
else
	TARGET="slide"
	FUNC="apply_slide"
	LABEL="SLIDE"
	DESC="window + workspace slide"
fi

# apply via Lua module (hyprctl eval runs in Hyprland's Lua VM)
if ! hyprctl eval "require('animations').$FUNC()" >/dev/null 2>&1; then
	echo "anim-toggle: hyprctl eval failed for $FUNC" >&2
	exit 1
fi

mkdir -p "$(dirname "$STATE_FILE")"
echo "$TARGET" > "$STATE_FILE"

# notify - simple
if command -v noctalia >/dev/null 2>&1; then
	noctalia msg notification-show "Animations" "changed to $TARGET" 2>/dev/null || notify-send "Animations" "changed to $TARGET"
else
	notify-send "Animations" "changed to $TARGET"
fi

echo "Switched to $TARGET"
