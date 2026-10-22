#!/usr/bin/env bash
# glass-toggle.sh — Alt+; toggle between the glass look and fully opaque.
#
# Toggles BOTH layers at once:
#   1. Hyprland  — decoration opacity 0.78/0.8 + blur (size 5, 2 passes)
#                  <-> opacity 1.0 / no blur. This covers every window,
#                  including GTK4 apps: their transparency comes from these
#                  values and their CSS only declares the blur region
#                  (backdrop-filter >= 20px in noctalia/templates/gtk4.css),
#                  so no gtk.css edit or app restart is needed.
#   2. Noctalia  — bar.main.background_opacity 0.77 + shell.panel
#                  transparency_mode "glass"  <->  1.0 + "solid".
#                  Noctalia has no IPC for this, so settings.toml is edited
#                  in place and reloaded with `noctalia msg config-reload`
#                  (verified: bar re-renders live). settings.toml wins over
#                  config.toml, so that is the file to change.
#
# Values mirror ~/.config/hypr/looknfeel.lua and the current Noctalia GUI
# settings (2026-10-21). Runtime only: `hyprctl reload` restores looknfeel.lua.
set -euo pipefail

NOCTALIA_SETTINGS="${XDG_STATE_HOME:-$HOME/.local/state}/noctalia/settings.toml"
GLASS_MODE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr-glass-mode"

set_noctalia() { # $1 = glass | solid
    [ -f "$NOCTALIA_SETTINGS" ] || return 0
    python3 - "$NOCTALIA_SETTINGS" "$1" <<'PY'
import re, sys

path, mode = sys.argv[1], sys.argv[2]
panel_mode = "glass" if mode == "glass" else "solid"
bar_opacity = "0.77" if mode == "glass" else "1.0"

lines = open(path).read().splitlines(True)
section = None
for i, line in enumerate(lines):
    stripped = line.strip()
    if stripped.startswith("["):
        section = stripped
        continue
    indent = line[: len(line) - len(line.lstrip())]
    if section == "[shell.panel]" and re.match(r"transparency_mode\s*=", stripped):
        lines[i] = f'{indent}transparency_mode = "{panel_mode}"\n'
    elif section == "[bar.main]" and re.match(r"background_opacity\s*=", stripped):
        lines[i] = f'{indent}background_opacity = {bar_opacity}\n'

open(path, "w").writelines(lines)
PY
    noctalia msg config-reload >/dev/null 2>&1 || true
}

hypr_glass_on() {
    hyprctl eval 'hl.config({ decoration = {
        active_opacity = 0.78,
        inactive_opacity = 0.8,
        blur = { enabled = true, size = 5, passes = 2, noise = 0.02,
                 contrast = 1.1, brightness = 0.9, ignore_opacity = true,
                 new_optimizations = true, xray = false },
    } })' >/dev/null
}

hypr_glass_off() {
    hyprctl eval 'hl.config({ decoration = {
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = { enabled = false },
    } })' >/dev/null
}

blur_state="$(hyprctl getoption decoration:blur:enabled | awk -F': ' '/^bool:/{print $2}')"

if [ "$blur_state" = "true" ]; then
    printf 'off\n' >"$GLASS_MODE_FILE"
    hypr_glass_off
    set_noctalia solid
    noctalia msg notification-show "glass off" "opaque" >/dev/null 2>&1 || true
else
    printf 'on\n' >"$GLASS_MODE_FILE"
    hypr_glass_on
    set_noctalia glass
    noctalia msg notification-show "glass on" "translucent" >/dev/null 2>&1 || true
fi
