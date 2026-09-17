#!/usr/bin/env bash
# blur-toggle.sh — toggle blur vs solid desktop
# Bound to ALT + ;
# GLASS:  windows 0.87 active / 0.82 inactive + blur on,
#         noctalia bar/notification/osd 0.87 + panel transparency soft
# SOLID:  windows 1.0/1.0 + blur off,
#         noctalia bar/notification/osd 1.0 + panel transparency solid
# State persisted in ~/.cache/hypr-blur-mode; --apply re-applies saved
# state without flipping (used by hypr autostart for reboot persistence).

set -euo pipefail

STATE_FILE="$HOME/.cache/hypr-blur-mode"
SETTINGS="$HOME/.local/state/noctalia/settings.toml"
CONFIG="$HOME/.config/noctalia/config.toml"

MODE="$(cat "$STATE_FILE" 2>/dev/null || echo "solid")"
if [ "${1:-}" = "--apply" ]; then
  TARGET="$MODE"
elif [ "$MODE" = "blur" ]; then
  TARGET="solid"
else
  TARGET="blur"
fi

if [ "$TARGET" = "blur" ]; then
  ACT_OP="0.87"; INACT_OP="0.82"; BLUR="true"
  N_OP="0.87"; PANEL_TR="soft"; LABEL="blur mode"
else
  ACT_OP="1.0"; INACT_OP="1.0"; BLUR="false"
  N_OP="1.0"; PANEL_TR="solid"; LABEL="solid mode"
fi

# 1. Hyprland windows (runtime merge, no file edits)
hyprctl eval "hl.config({ decoration = { active_opacity = $ACT_OP, inactive_opacity = $INACT_OP, blur = { enabled = $BLUR } } })" >/dev/null

# 2. Noctalia: bar.main + notification + osd opacities, panel transparency.
# Section-aware line edit (preserves formatting); values verified to change.
python3 - "$SETTINGS" "$CONFIG" "$N_OP" "$PANEL_TR" <<'PYEOF'
import re, sys
settings_path, config_path, n_op, panel_tr = sys.argv[1:5]
with open(settings_path) as f:
    lines = f.readlines()
section = None
changed = 0
for i, line in enumerate(lines):
    m = re.match(r"^\s*(\[.+?\])\s*$", line)
    if m:
        section = m.group(1)
        continue
    if section in ("[bar.main]", "[notification]", "[osd]") \
            and re.match(r"^\s*background_opacity\s*=", line):
        lines[i] = re.sub(r"=\s*[\d.]+", "= " + n_op, line)
        changed += 1
with open(settings_path, "w") as f:
    f.writelines(lines)
print(f"noctalia opacities: {changed}/3", flush=True)
assert changed == 3, "expected 3 opacity lines!"
with open(config_path) as f:
    cfg = f.read()
cfg, n = re.subn(r'^transparency_mode\s*=.*$',
                 f'transparency_mode = "{panel_tr}"', cfg, flags=re.M)
assert n == 1, "transparency line not found!"
with open(config_path, "w") as f:
    f.write(cfg)
print("panel transparency ok", flush=True)
PYEOF
noctalia msg config-reload >/dev/null 2>&1 || true

mkdir -p "$(dirname "$STATE_FILE")"
echo "$TARGET" > "$STATE_FILE"

if [ "${1:-}" != "--apply" ]; then
  noctalia msg notification-show "Blur" "$LABEL" 2>/dev/null \
    || notify-send "Blur" "$LABEL"
  echo "Switched to $LABEL"
fi
