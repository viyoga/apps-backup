#!/bin/bash
hyprshot -m region -r --clipboard-only | tesseract - - 2>/dev/null | wl-copy
notify-send "Textshot" "Extracted text copied to clipboard"
