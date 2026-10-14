#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/Desktop/apps-backup"
CFG="$HOME/.config"
DEST="$REPO/configs"
SHELL_DEST="$REPO/shell"

mkdir -p "$DEST" "$SHELL_DEST"
cd "$REPO"

# rsync helper: mirror a config dir, dropping junk
# usage: sync_dir <name> [extra rsync args...]
sync_dir() {
  local name="$1"; shift
  mkdir -p "$DEST/$name"
  rsync -a --delete \
    --exclude='*.bak*' \
    --exclude='*.old' \
    --exclude='*~' \
    --exclude='.git/' \
    --exclude='__pycache__/' \
    --exclude='node_modules/' \
    "$@" \
    "$CFG/$name/" "$DEST/$name/"
}

# --- confirmed apps ---
sync_dir nvim
sync_dir mpv --exclude='watch_later/'
sync_dir rmpc
sync_dir yazi
sync_dir gtk-3.0
sync_dir gtk-4.0
sync_dir spicetify
sync_dir fastfetch
sync_dir zathura
sync_dir kitty
sync_dir hypr
sync_dir btop
sync_dir cava
sync_dir Kvantum
sync_dir qt5ct
sync_dir qt6ct
sync_dir fontconfig
sync_dir nwg-look
sync_dir zsh
sync_dir yt-dlp
sync_dir imv
sync_dir bat

# --- mpd: only conf + playlists (skip log/database/state/sticker) ---
mkdir -p "$DEST/mpd/playlists"
cp -f "$CFG/mpd/mpd.conf" "$DEST/mpd/mpd.conf"
rsync -a --delete --exclude='*.bak*' "$CFG/mpd/playlists/" "$DEST/mpd/playlists/"

# --- obsidian: only obsidian.json + snippets (skip 300MB Electron Cache/GPUCache/etc) ---
mkdir -p "$DEST/obsidian/snippets"
cp -f "$CFG/obsidian/obsidian.json" "$DEST/obsidian/obsidian.json" 2>/dev/null || true
rsync -a --delete "$CFG/obsidian/snippets/" "$DEST/obsidian/snippets/" 2>/dev/null || true
# NOTE: real vaults live in ~/Documents/Obsidian-vaults/ — back those up separately

# --- vesktop: only settings + themes (skip sessionData/Cache/Crashpad) ---
mkdir -p "$DEST/vesktop/settings" "$DEST/vesktop/themes"
cp -f "$CFG/vesktop/settings.json" "$DEST/vesktop/settings.json" 2>/dev/null || true
cp -f "$CFG/vesktop/settings/settings.json" "$DEST/vesktop/settings/settings.json" 2>/dev/null || true
cp -f "$CFG/vesktop/settings/quickCss.css" "$DEST/vesktop/settings/quickCss.css" 2>/dev/null || true
rsync -a --delete --exclude='*.bak*' "$CFG/vesktop/themes/" "$DEST/vesktop/themes/" 2>/dev/null || true

# --- browser flags ---
for f in "$CFG"/brave*-flags.conf; do
  [ -f "$f" ] && cp -f "$f" "$DEST/"
done

# --- shell ---
for f in .zshrc .zpreztorc .p10k.zsh .zprofile .zshenv .zlogin .zlogout .bashrc .bash_profile; do
  [ -f "$HOME/$f" ] && cp -f "$HOME/$f" "$SHELL_DEST/$f"
done

notify() {
  noctalia msg notification-show "Apps backup" "$1" >/dev/null 2>&1 || true
}

if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "Auto backup: $(date '+%Y-%m-%d %H:%M')" >/dev/null 2>&1
  HASH="$(git rev-parse --short HEAD)"
  if git push origin main 2>/dev/null; then
    notify "Backed up & pushed commit $HASH"
  else
    notify "Committed $HASH but push skipped (offline?)"
  fi
else
  notify "No changes"
fi
