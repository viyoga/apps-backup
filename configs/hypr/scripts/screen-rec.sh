#!/usr/bin/env bash
# Toggle screen recording (gpu-screen-recorder via noctalia screen_recorder plugin)
# usage: screen-rec.sh [with|without]  — cursor mode for the next recording
# Sends a Noctalia notification on start.

SETTINGS="$HOME/.local/state/noctalia/settings.toml"
MODE="${1:-}"

if [ "$MODE" = "with" ]; then
  CURSOR_TEXT="with cursor"
  sed -i 's/^show_cursor = .*/show_cursor = true/' "$SETTINGS"
  sed -i 's/^video_qp = .*/video_qp = 25/' "$SETTINGS"
elif [ "$MODE" = "without" ]; then
  CURSOR_TEXT="without cursor"
  sed -i 's/^show_cursor = .*/show_cursor = false/' "$SETTINGS"
  sed -i 's/^video_qp = .*/video_qp = 5/' "$SETTINGS"
else
  if rg -q '^show_cursor = true' "$SETTINGS" 2>/dev/null; then
    CURSOR_TEXT="with cursor"
  else
    CURSOR_TEXT="without cursor"
  fi
fi

if pgrep -f '^gpu-screen-recorder -w ' >/dev/null 2>&1; then
  # currently recording -> stop
  noctalia msg plugin noctalia/screen_recorder:service all toggle
else
  # not recording -> start with the cursor mode written above.
  # NO `noctalia msg config-reload` here: it re-serialises Noctalia's state from
  # a half-loaded model and truncates ~/.local/state/noctalia/settings.toml to a
  # ~40-line stub (bar/dock/wallpaper/palette/plugins wiped). Verified on
  # noctalia-git r5828 and r5881, 2026-10-22. The written show_cursor/video_qp
  # values are picked up by the plugin on the next shell start.
  noctalia msg plugin noctalia/screen_recorder:service all toggle
  noctalia msg notification-show "Screen recording started" "Recording $CURSOR_TEXT"
fi