#!/bin/sh

socket="/tmp/modern_labwc_mpv.sock"

# Check if rofi-tube is running
if pgrep -f "rofi-tube.sh" > /dev/null; then
    # Hide OSC then show rofi-tube playlist window
    [ -S "$socket" ] && echo '{ "command": ["script-message-to", "modernz", "osc-hide"] }' | socat - "$socket" > /dev/null 2>&1
    bash ~/.config/rofi/rofi-tube/rofi-tube.sh --show-playlist    
else
    # Check if socket exists before using it
    if [ -S "$socket" ]; then
    (
        echo '{ "command": ["script-message-to", "modernz", "osc-hide"] }'
        echo '{ "command": ["script-message-to", "modernz", "menu-toggle", "playlist" ] }'
    ) | socat - "$socket" > /dev/null 2>&1
    else
        echo "mpv socket not found"
    fi
fi


