#!/usr/bin/env bash
# Toggle Hyprland layout: dwindle <-> scrolling ("rolling")
#
# NOTE: this Lua-config Hyprland build rejects `hyprctl keyword`
# ("non-legacy parsers"), so runtime changes go through hl.config /
# hl.animation via hyprctl eval. Partial tables merge cleanly.
#
# DEFAULTS (looknfeel.lua): layout = scrolling, windows/windowsMove =
# bounce/5/slide — full parity with the workspaces leaf. After reload or
# reboot you land back in ROLLING with bounce; Super+; temporarily drops
# to dwindle (easeOut/4.5) until the next toggle/reload.
#
# State source: activeworkspace .tiledLayout — getoption general:layout
# lags one step behind hl.config evals (async commit), which breaks
# rapid toggling; tiledLayout is fresh immediately.

current=$(hyprctl activeworkspace -j | jq -r '.tiledLayout // empty')

if [ "$current" = "scrolling" ]; then
	target="dwindle"
	label="dwindle"
	anim_bezier="easeOut"
	anim_speed="4.5"
	anim_style=""
else
	target="scrolling"
	label="rolling"
	# FULL parity with workspaces leaf: bounce / 5 / slide
	anim_bezier="bounce"
	anim_speed="5"
	anim_style="slide"
fi

if ! hyprctl eval "hl.config{ general = { layout = \"$target\" } }" >/dev/null; then
	echo "layout-toggle: failed to set layout to $target" >&2
	exit 1
fi

for leaf in windows windowsMove; do
	hyprctl eval "hl.animation({ leaf = \"$leaf\", enabled = true, speed = $anim_speed, bezier = \"$anim_bezier\", style = \"$anim_style\" })" >/dev/null
done

# settle: config/animation evals commit asynchronously — give them a beat
# so a rapid next press reads fresh state
sleep 0.3

noctalia msg notification-show "Layout" "Layout switched to ${label}"
