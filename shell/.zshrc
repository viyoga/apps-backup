# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Custom prompt
#PROMPT='%F{#88C0D0}󰘧 ❯ %f'

# Added the Zoxide prompt 
eval "$(zoxide init --cmd cd zsh)"

# Change icons with a single command xD:)
ic() {
    local theme="Yaru-${1}"
    sed -i "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=${theme}/" ~/.config/gtk-3.0/settings.ini
    sed -i "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=${theme}/" ~/.config/gtk-4.0/settings.ini
    gsettings set org.gnome.desktop.interface icon-theme "${theme}"
    pkill nautilus
    echo "Icon theme set to ${theme} and Nautilus restarted"
}

pp() {
    local color="${1}"
    sudo papirus-folders -C "${color}" --theme Papirus-Dark
    sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Papirus-Dark/' ~/.config/gtk-3.0/settings.ini
    sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Papirus-Dark/' ~/.config/gtk-4.0/settings.ini
    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
    pkill nautilus
    echo "Papirus folders set to ${color} and Nautilus restarted"
}

#aliases
alias ff='fastfetch'
alias cc='clear'
alias rr='reset'
alias unimatrix='unimatrix -n -s 96 -l 'o''
alias hdd='cd /mnt/hdd && yazi'
alias yz='yazi'
alias yt='yt-dlp'
alias iy='yay -S'
alias ip='yay -S'
alias u='sudo pacman -Syu'
alias r='sudo pacman -Rns'
alias yz='yazi'
f() {
  local file
  file=$(fzf -m --height=60% --preview="bat --color=always {}") || return
  nvim ${(f)file}
}
alias nm='nmcli dev wifi connect S23'

alias ls='eza -lG --icons --no-user --no-permissions --no-time --group-directories-first'
alias lt='eza --tree --level=2 --icons --no-user --no-permissions --no-time --long'
alias lls='eza -la --icons --total-size'
alias ll='eza -la --icons'
alias ww='sudo systemctl stop waydroid-container'
alias wifi='sudo modprobe mt7601u && nmrs'
alias wrun='cd ~/esoteric && zola build && kill $(lsof -ti :8082) 2>/dev/null; nohup python3 serve-https.py > /tmp/zola-https.log 2>&1 & disown'


export PATH=$PATH:/home/kabir/.spicetify
export QT_QPA_PLATFORMTHEME=qt5ct


export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"


# for yt-dlp
export PATH="$HOME/.local/bin:$PATH"

ytd() {
    local dirs=("Videos (root)")
    for d in ~/Videos/*/; do
        [[ -d "$d" ]] && dirs+=("$(basename "$d")")
    done

    local folder=$(printf "%s\n" "${dirs[@]}" | fzf --prompt="Download to > ")
    [[ -z "$folder" ]] && return
    [[ "$folder" = "Videos (root)" ]] && folder=""

    echo -e "\033[1;36m➜ Downloading to: $HOME/Videos/$folder\033[0m"
    printf '\033[33mPaste YouTube link: \033[0m'
    read -r url
    [[ -z "$url" ]] && return
    echo

    # Get video metadata to detect language
    local lang_info=$(yt-dlp --cookies-from-browser "brave+gnomekeyring:$HOME/.config/BraveSoftware/Brave-Origin-Nightly/Default" -J "$url" 2>/dev/null | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    # Get video spoken language
    vid_lang = data.get('language', '')
    # Get available automatic captions languages
    acaps = data.get('automatic_captions', {})
    langs = list(acaps.keys()) if acaps else ''
    # Output: video_language, available_auto_langs
    print(f'{vid_lang}|{','.join(langs)}')
except:
    print('|')
" 2>/dev/null)

    local video_lang=""
    local auto_langs=""
    if [[ -n "$lang_info" ]]; then
        video_lang=$(echo "$lang_info" | cut -d'|' -f1)
        auto_langs=$(echo "$lang_info" | cut -d'|' -f2)
    fi

    # Determine subtitle language: prefer video's spoken language, then available auto-caps, then English
    local sub_lang=""
    if [[ -n "$video_lang" && "$video_lang" != "None" ]]; then
        # Try video's spoken language first
        sub_lang="$video_lang"
    elif [[ -n "$auto_langs" ]]; then
        # Use first available auto-generated caption language
        sub_lang=$(echo "$auto_langs" | cut -d',' -f1)
    fi

    # Fall back to English if nothing else available
    if [[ -z "$sub_lang" ]]; then
        sub_lang="en"
    fi

    echo -e "\033[33mDetected subtitle language: $sub_lang\033[0m"

    yt-dlp --cookies-from-browser "brave+gnomekeyring:$HOME/.config/BraveSoftware/Brave-Origin-Nightly/Default" \
        --write-subs --write-auto-sub --sub-lang "$sub_lang" --convert-subs srt --embed-subs \
        -f "bv*[ext=mp4]+ba[ext=m4a]/best[ext=mp4]/best" \
        --concurrent-fragments 4 --retries 20 --fragment-retries 20 --socket-timeout 30 \
        -P "$HOME/Videos/$folder" "$url"
}

for _t in arcdark atomdark ayu ayu-dark ayu-light ayu-mirage cat-frappe cat-latte \
    catppuccin cyberpunk dracula everforest github-light gruvbox kanagawa material \
    melange-dark melange-light monokai night-owl nord oceanic-next onedark palenight \
    rose-pine shades-of-purple solarized srcery sunset-aurant sunset-saffron \
    sunset-tangerine synthwave-84 tokyo-dark tokyo-moon tokyo-storm; do
    eval "function $_t() { gowall convert \"\$@\" -t $_t; }"
done
unset _t

export SHELL=/usr/bin/zsh
# source ~/.powerlevel10k/powerlevel10k.zsh-theme

# FZF integration
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/shell/fzf-colors"

# FZF navigation with Alt+vim keys
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind='alt-j:down,alt-k:up,alt-h:preview-up,alt-l:preview-down'"

# Override fzf Alt+C to use zoxide cd instead of builtin cd
fzf-cd-widget() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(
    FZF_DEFAULT_COMMAND=${FZF_ALT_C_COMMAND:-} \
    FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${FZF_ALT_C_OPTS-} +m") \
    FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd) < /dev/tty)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line
  BUFFER="cd ${(q)dir:a}"
  zle accept-line
  local ret=$?
  unset dir
  zle reset-prompt
  return $ret
}
zle -N fzf-cd-widget

# Rebind fzf: Alt+T for files, Alt+R for history (instead of Ctrl+T, Ctrl+R)
bindkey '^T' ''
bindkey -M emacs '\ep' fzf-file-widget
bindkey '^R' ''
bindkey -M emacs '\er' fzf-history-widget

# Obsidian vault git shortcuts
pushg() {
  cd ~/Documents/Obsidian-vaults/Vault-1 && git add . && git commit -m "update notes" && git push
}

pullg() {
  cd ~/Documents/Obsidian-vaults/Vault-1 && git pull
}

# Dotfiles git shortcuts
pushgd() {
  cd ~/dotfiles && git add -A && git commit -m "update" && git push
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH=/home/kabir/.opencode/bin:$PATH




# Added by Antigravity CLI installer
export PATH="/home/kabir/.local/bin:$PATH"
