#!/bin/bash

MUSIC_DIR="/mnt/hdd/Music"
COVER="/tmp/mpd-cover.jpg"

get_album_art() {
    local file="$MUSIC_DIR/$1"
    ffmpeg -y -i "$file" -an -vcodec copy "$COVER" 2>/dev/null
    if [[ -f "$COVER" && -s "$COVER" ]]; then
        echo "$COVER"
        return 0
    fi
    local dir
    dir=$(dirname "$file")
    for candidate in "cover.jpg" "cover.png" "folder.jpg" "Front.jpg"; do
        if [[ -f "$dir/$candidate" ]]; then
            echo "$dir/$candidate"
            return 0
        fi
    done
    echo ""
}

player_state() {
    mpc status "%state%"
}

while true; do
    mpc idle player 2>/dev/null
    state=$(player_state)
    [[ "$state" != "playing" ]] && continue

    title=$(mpc current -f "%title%")
    [[ -z "$title" ]] && title=$(mpc current -f "%file%" | sed 's/.*\///; s/\.[^.]*$//')
    artist=$(mpc current -f "%artist%")
    album=$(mpc current -f "%album%")
    file=$(mpc current -f "%file%")

    art=$(get_album_art "$file")

    if [[ -n "$art" ]]; then
        notify-send -i "$art" -h string:x-canonical-private-synchronous:mpd "$title" "$artist"
    else
        notify-send -h string:x-canonical-private-synchronous:mpd "$title" "$artist"
    fi
done
