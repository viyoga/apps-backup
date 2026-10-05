#!/usr/bin/env bash
# serein-focus.sh — focus-or-launch for Serein (ALT+D).
# When Serein is running (whether visible or hidden in the system tray),
# activates its StatusNotifierItem over D-Bus (exact equivalent of clicking
# the tray icon), unhiding it from special:serein-tray onto the active
# workspace and focusing it. If fully closed, launches a new instance.
set -euo pipefail

serein_pid=$(pgrep -x serein 2>/dev/null | head -n 1 || true)

if [ -n "$serein_pid" ]; then
  activated=0

  # Query registered StatusNotifierItems
  items=$(busctl --user get-property org.kde.StatusNotifierWatcher /StatusNotifierWatcher org.kde.StatusNotifierWatcher RegisteredStatusNotifierItems 2>/dev/null || true)
  if [ -n "$items" ]; then
    for item in $(echo "$items" | grep -oP '"\K[^"]+'); do
      service="${item%%/*}"
      path="${item#"$service"}"
      [ -z "$path" ] && path="/StatusNotifierItem"

      id=$(busctl --user get-property "$service" "$path" org.kde.StatusNotifierItem Id 2>/dev/null || true)
      if [[ "$id" =~ "serein" ]]; then
        busctl --user call "$service" "$path" org.kde.StatusNotifierItem Activate ii 0 0 >/dev/null 2>&1 || true
        activated=1
        break
      fi

      # Secondary check by PID in case Id didn't match
      conn_pid=$(busctl --user call org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus GetConnectionUnixProcessID s "$service" 2>/dev/null | awk '{print $2}' || true)
      if [ "$conn_pid" = "$serein_pid" ]; then
        busctl --user call "$service" "$path" org.kde.StatusNotifierItem Activate ii 0 0 >/dev/null 2>&1 || true
        activated=1
        break
      fi
    done
  fi

  # Fallback if D-Bus activation didn't find the item:
  # Move out of special:serein-tray to the active workspace
  if [ "$activated" -eq 0 ]; then
    active_ws=$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.id // .name' || true)
    if [ -n "$active_ws" ]; then
      hyprctl dispatch "hl.dsp.window.move({ window = \"class:cz.viceverse.serein\", workspace = \"$active_ws\", follow = false })" >/dev/null 2>&1 || true
    fi
  fi

  # Always focus the window
  hyprctl dispatch 'hl.dsp.focus({ window = "class:cz.viceverse.serein" })' >/dev/null 2>&1 || true
else
  # Fully closed: launch new instance via Hyprland
  hyprctl dispatch 'hl.dsp.exec_cmd("serein")' >/dev/null 2>&1 || nohup setsid serein >/dev/null 2>&1 &
fi
