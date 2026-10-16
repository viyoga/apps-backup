# ==============================================================================
#  Aliases
# ==============================================================================

# Core utilities
alias ff='fastfetch'
alias cc='clear'
alias rr='reset'
alias rs='reset'
alias unimatrix="unimatrix -n -s 96 -l 'o'"
alias cmatrix='cmatrix-noctalia'
alias cm='cmatrix-noctalia'
alias hdd='cd /mnt/hdd && yazi'
alias yz='yazi'
alias asciiquarium='asciiquarium -t'
alias tt='tubetui'
alias ym='ytm'

# Package management
alias iy='yay -S'
alias u='sudo pacman -Syu'
alias r='sudo pacman -Rns'

# Eza (modern ls)
alias ls='eza -lG --icons --no-user --no-permissions --no-time --group-directories-first'
alias lt='eza --tree --level=2 --icons --no-user --no-permissions --no-time --long'
alias lls='eza -la --icons --total-size'
alias ll='eza -la --icons'

# Services & Projects
alias ww='sudo systemctl stop waydroid-container'
alias wrun='cd ~/esoteric && zola build && kill $(lsof -ti :8082) 2>/dev/null; nohup python3 serve-https.py > /tmp/zola-https.log 2>&1 & disown'
