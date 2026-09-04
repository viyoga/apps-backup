#!/usr/bin/env bash
TODO_FILE="$HOME/Documents/Obsidian-vaults/Vault-1/notes/todo.md"
touch "$TODO_FILE"

choice=$(sed 's/^- \[ \] / /; s/^- \[x\] / /' "$TODO_FILE" |
  rofi -dmenu -p "Todo" -kb-custom-1 "Ctrl+Delete" -theme ~/.config/rofi/todo.rasi)
ret=$?
[ -z "$choice" ] && exit 0

task="${choice# }"
task="${task# }"

if [ "$ret" -eq 10 ]; then
  awk -v t="$task" '$0 != "- [ ] " t && $0 != "- [x] " t' "$TODO_FILE" > "${TODO_FILE}.tmp" && mv "${TODO_FILE}.tmp" "$TODO_FILE"
else
  awk -v t="$task" '
    $0 == "- [ ] " t { sub(/\[ \]/, "[x]"); f=1; print; next }
    $0 == "- [x] " t { sub(/\[x\]/, "[ ]"); f=1; print; next }
    { print }
    END { if (!f) print "- [ ] " t }
  ' "$TODO_FILE" > "${TODO_FILE}.tmp" && mv "${TODO_FILE}.tmp" "$TODO_FILE"
fi
