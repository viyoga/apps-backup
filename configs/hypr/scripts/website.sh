#!/usr/bin/env bash
choice=$(
  printf "anime\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/anime.png\nchatgpt\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/chatgpt-light.png\nes0terikitty\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/es0terikitty.jpg\ndashboardsicons\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/dashboard-icons.png\ndrive\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/google-drive.png\neverythingmoe\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/everythingmoe.png\nfmhy\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/fmhy.png\ngemini\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/gemini-color.png\nmaps\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/google-maps.png\nreddit\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/reddit.png\nsyncthing\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/syncthing.png\ntwitter\x00icon\x1f/home/kabir/Pictures/icons/rofi-icons/twitter.png" |
    rofi -dmenu -p "Website" -show-icons -theme ~/.config/rofi/website.rasi
)
ret=$?
[ -z "$choice" ] && exit 0

case "$choice" in
anime) url="https://mkissa.to" ;;
chatgpt) url="https://chatgpt.com" ;;
es0terikitty) url="https://es0terikitty.github.io" ;;
dashboardicons) url="https://dashboardicons.com" ;;
drive) url="https://drive.com" ;;
everythingmoe) url="https://everythingmoe.com" ;;
fmhy) url="https://fmhy.net/video#anime-streaming" ;;
gemini) url="https://gemini.google.com" ;;
maps) url="https://maps.google.com" ;;
reddit) url="https://reddit.com" ;;
syncthing) url="http://127.0.0.1:8384/" ;;
twitter) url="https://x.com" ;;
*)
  if [[ "$choice" =~ ^yy\  ]]; then
    query="${choice#yy }"
    url="https://www.youtube.com/results?search_query=${query// /+}"
  elif [[ "$choice" == http://* || "$choice" == https://* ]]; then
    url="$choice"
  elif [[ "$choice" =~ ^[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+(:[0-9]+)?(/.*)?$ ]]; then
    url="https://$choice"
  elif [[ "$choice" =~ ^localhost(:[0-9]+)?(/.*)?$ ]]; then
    url="http://$choice"
  else
    url="https://www.google.com/search?q=${choice// /+}"
  fi
  ;;
esac

if [ "$ret" -eq 10 ]; then
  helium-browser --incognito "$url"
else
  xdg-open "$url"
fi
