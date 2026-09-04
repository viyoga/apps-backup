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
  # not recording -> apply cursor mode, then start
  noctalia msg config-reload
  sleep 0.5
  noctalia msg plugin noctalia/screen_recorder:service all toggle
  noctalia msg notification-show "Screen recording started" "Recording $CURSOR_TEXT"
fi