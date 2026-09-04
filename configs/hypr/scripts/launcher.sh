#!/bin/bash
# ~/.config/hypr/scripts/launcher.sh

FREQ_FILE="$HOME/.cache/rofi-launcher-freq"
touch "$FREQ_FILE"

# Build app list sorted by frequency (most used first)
APP=$(grep -rhl "" /usr/share/applications ~/.local/share/applications 2>/dev/null |
  while read -r f; do
    name="" icon="" exec="" nodisplay="" terminal=""
    while IFS='=' read -r key val; do
      case "$key" in
      "Name") [[ -z "$name" ]] && name="$val" ;;
      "Icon") [[ -z "$icon" ]] && icon="$val" ;;
      "Exec") [[ -z "$exec" ]] && exec="$val" ;;
      "Terminal") terminal="$val" ;;
      "NoDisplay") nodisplay="$val" ;;
      esac
    done <"$f"
    [[ -n "$name" && -n "$exec" && "$nodisplay" != "true" ]] &&
      echo -en "${name}\x00icon\x1f${icon}\n"
  done |
  sort -u |
  awk -v freq="$FREQ_FILE" '
        BEGIN { while ((getline line < freq) > 0) { split(line, a, "\t"); count[a[2]] = a[1] } }
        { n = $0; sub(/\x00.*/, "", n); c = count[n]+0; printf "%d\t%s\n", c, $0 }
    ' |
  sort -t$'\t' -rn -k1,1 -k2 |
  cut -f2- |
  rofi -dmenu -p " Apps" -show-icons -i \
    -theme ~/.config/rofi/launcher.rasi)

[[ -z "$APP" ]] && exit 0

# Increment frequency count
CLEAN_APP=$(echo "$APP" | cut -f1)
if grep -q "	${CLEAN_APP}$" "$FREQ_FILE" 2>/dev/null; then
  sed -i "/\t${CLEAN_APP}$/s/^[0-9]*/$(($(grep -m1 "\t${CLEAN_APP}$" "$FREQ_FILE" | cut -f1) + 1))/" "$FREQ_FILE"
else
  echo -e "1\t${CLEAN_APP}" >>"$FREQ_FILE"
fi

# Find and launch
EXEC=$(grep -rhl "" /usr/share/applications ~/.local/share/applications 2>/dev/null |
  while read -r f; do
    name="" exec="" terminal="" nodisplay=""
    while IFS='=' read -r key val; do
      case "$key" in
      "Name") [[ -z "$name" ]] && name="$val" ;;
      "Exec") [[ -z "$exec" ]] && exec="$val" ;;
      "Terminal") terminal="$val" ;;
      "NoDisplay") nodisplay="$val" ;;
      esac
    done <"$f"
    [[ "$name" == "$CLEAN_APP" && "$nodisplay" != "true" ]] && {
      [[ "$terminal" == "true" ]] && echo "kitty -e $exec" || echo "$exec"
      break
    }
  done | head -1)

EXEC=$(echo "$EXEC" | sed 's/ %[uUfFdDnNickvm]//g')
[[ -z "$EXEC" ]] && exit 1
exec bash -c "$EXEC"
