#!/usr/bin/env bash
# glass-toggle.sh — Alt+; toggles window translucency + blur.
#
# HYPRLAND ONLY, on purpose. This script must never talk to Noctalia:
# `noctalia msg config-reload` makes Noctalia re-serialise its state from a
# half-loaded model and truncates ~/.local/state/noctalia/settings.toml from
# ~541 lines to a ~40-line stub holding only [lockscreen_widgets], which wipes
# the bar layout, dock, wallpaper, palette and plugin settings. Verified on
# noctalia-git r5828 and r5881 on 2026-10-22, with no edits involved.
#
# Consequence: only windows toggle. The bar/panels keep their own opacity.
set -euo pipefail

MODE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr-glass-mode"

blur_state="$(hyprctl getoption decoration:blur:enabled | awk -F': ' '/^bool:/{print $2}')"

if [ "$blur_state" = "true" ]; then
    printf 'off\n' >"$MODE_FILE"
    hyprctl eval 'hl.config({ decoration = {
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = { enabled = false },
    } })' >/dev/null
    notify-send -a hypr -t 1200 "glass off" "windows opaque" 2>/dev/null || true
else
    printf 'on\n' >"$MODE_FILE"
    hyprctl eval 'hl.config({ decoration = {
        active_opacity = 0.78,
        inactive_opacity = 0.8,
        blur = { enabled = true, size = 5, passes = 2, noise = 0.02,
                 contrast = 1.1, brightness = 0.9, ignore_opacity = true,
                 new_optimizations = true, xray = false },
    } })' >/dev/null
    notify-send -a hypr -t 1200 "glass on" "windows translucent" 2>/dev/null || true
fi
