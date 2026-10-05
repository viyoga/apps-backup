#!/usr/bin/env bash
# kill-tray-apps.sh — Close all running system tray applications (ALT+SHIFT+A).
# Finds all StatusNotifierItem registrations on D-Bus, filters out protected
# system/desktop components, terminates the tray processes gracefully (SIGTERM),
# falls back to SIGKILL if unresponsive, and sends a desktop notification.
set -euo pipefail

# Blacklist of protected process names that must NEVER be killed
is_protected() {
  local comm="$1"
  case "$comm" in
    noctalia|Hyprland|hyprland|systemd|waybar|pipewire|wireplumber|dbus*|polkit*|xdg*|bash|zsh|sh)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# Query registered StatusNotifierItems from Watcher
items=$(busctl --user get-property org.kde.StatusNotifierWatcher /StatusNotifierWatcher org.kde.StatusNotifierWatcher RegisteredStatusNotifierItems 2>/dev/null || true)

declare -A seen_pids
pids_to_kill=()
killed_names=()

if [ -n "$items" ]; then
  for item in $(echo "$items" | grep -oP '"\K[^"]+'); do
    service="${item%%/*}"
    [ -z "$service" ] && continue

    path="${item#"$service"}"
    [ -z "$path" ] && path="/StatusNotifierItem"

    pid=$(busctl --user call org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus GetConnectionUnixProcessID s "$service" 2>/dev/null | awk '{print $2}' || true)
    
    if [ -n "$pid" ] && [ "$pid" -gt 1 ] && [ "$pid" -ne "$$" ] && [ -z "${seen_pids[$pid]:-}" ]; then
      seen_pids["$pid"]=1
      comm=$(ps -p "$pid" -o comm= 2>/dev/null || true)

      if [ -n "$comm" ] && ! is_protected "$comm"; then
        title=$(busctl --user get-property "$service" "$path" org.kde.StatusNotifierItem Title 2>/dev/null | awk -F'"' '{print $2}' || true)
        id=$(busctl --user get-property "$service" "$path" org.kde.StatusNotifierItem Id 2>/dev/null | awk -F'"' '{print $2}' || true)

        display_name="${title:-${id:-$comm}}"
        pids_to_kill+=("$pid")
        killed_names+=("$display_name")
      fi
    fi
  done
fi

if [ "${#pids_to_kill[@]}" -eq 0 ]; then
  notify-send -a "System Tray" -i dialog-information "Tray Apps" "No tray applications running"
  exit 0
fi

# Send SIGTERM first for graceful exit (flushing state, sockets, configs)
for pid in "${pids_to_kill[@]}"; do
  kill -15 "$pid" 2>/dev/null || true
done

# Wait briefly for graceful shutdown
sleep 0.3

# Force SIGKILL if any remain alive
for pid in "${pids_to_kill[@]}"; do
  if kill -0 "$pid" 2>/dev/null; then
    kill -9 "$pid" 2>/dev/null || true
  fi
done

app_list=$(IFS=', '; echo "${killed_names[*]}")
notify-send -a "System Tray" -i application-exit "Tray Apps Closed" "Closed ${#killed_names[@]} app(s): $app_list"
