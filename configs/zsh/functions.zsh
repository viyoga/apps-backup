# ==============================================================================
#  Custom Functions & Shortcuts
# ==============================================================================

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

# Toggle `sudo` on current command line or last command with [ESC] [ESC]
sudo-command-line() {
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"
  if [[ $BUFFER == sudo\ * ]]; then
    LBUFFER="${LBUFFER#sudo }"
  elif [[ -n $BUFFER ]]; then
    LBUFFER="sudo $LBUFFER"
  fi
  zle redisplay
}
zle -N sudo-command-line
bindkey '\e\e' sudo-command-line
