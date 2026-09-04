#!/bin/bash
hyprpicker -a # -a auto-copies hex to clipboard
notify-send "Color Picker" "Copied $(wl-paste) to clipboard"
