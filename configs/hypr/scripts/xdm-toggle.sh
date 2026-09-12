#!/bin/bash
# Toggle XDMAN via the named scratchpad (special:xdm).
# Do NOT close XDM with SUPER+W: the window dies but the process stays,
# and a 2nd instance segfaults, leaving no way to reopen.
CLIENTS=$(hyprctl clients -j 2>/dev/null)
WS=$(echo "$CLIENTS" | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
except Exception:
    print('')
else:
    m = [c for c in d if c.get('class') == 'xdm-app']
    print(m[0].get('workspace', {}).get('name', '') if m else '')
")
if [ -n "$WS" ]; then
  case "$WS" in
    special*) hyprctl dispatch 'hl.dsp.workspace.toggle_special("xdm")' >/dev/null ;;
    *)
      hyprctl dispatch 'hl.dsp.focus({ window = "class:xdm-app" })' >/dev/null
      hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:xdm" })' >/dev/null ;;
  esac
else
  pgrep -x xdm-app >/dev/null && { pkill -9 -x xdm-app; sleep 1; }
  nohup env GTK_USE_PORTAL=1 /opt/xdman/xdm-app >/dev/null 2>&1 &
fi
