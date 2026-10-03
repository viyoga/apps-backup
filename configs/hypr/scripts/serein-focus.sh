#!/usr/bin/env bash
# serein-focus.sh — focus-or-launch for Serein (ALT+D).
# Serein has no single-instance guard: a bare launch spawns a full second
# copy (3-4s cold boot) while the hidden one sits parked. So: if alive,
# focus its window (pulls it off the tray workspace); else launch.
set -u

if pgrep -x serein >/dev/null; then
  hyprctl dispatch 'hl.dsp.focus({ window = "class:cz.viceverse.serein" })' >/dev/null 2>&1
else
  # Detached: the keybind must not wait on the app.
  nohup setsid serein >/dev/null 2>&1 &
fi
