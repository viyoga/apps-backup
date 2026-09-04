# apps-backup

Backup of selected app configs (not the whole `~/.config`). Same pattern as `noctalia-backup`: run `sync.sh`, it rsyncs + auto-commits + pushes.

```sh
./sync.sh
```

## What's included

| Area | Source |
|---|---|
| nvim | `~/.config/nvim` |
| mpv | `~/.config/mpv` (excl. `watch_later/`) |
| mpd | `~/.config/mpd/mpd.conf` + `playlists/` only |
| rmpc | `~/.config/rmpc` |
| yazi | `~/.config/yazi` |
| gtk | `~/.config/gtk-3.0`, `~/.config/gtk-4.0` |
| obsidian | `obsidian.json` + `snippets/` only |
| spicetify | `~/.config/spicetify` |
| fastfetch | `~/.config/fastfetch` |
| zathura | `~/.config/zathura` |
| hypr | `~/.config/hypr` |
| kitty | `~/.config/kitty` |
| btop, cava | `~/.config/btop`, `~/.config/cava` |
| theming | `Kvantum`, `qt5ct`, `qt6ct`, `fontconfig`, `nwg-look` |
| shell | `~/.zshrc`, `~/.zpreztorc`, `~/.p10k.zsh`, `~/.bashrc`, `~/.config/starship.toml` → `shell/` |

## Deliberately excluded

- `~/.config/obsidian` Cache/GPUCache/blob_storage (~300MB Electron junk). Real vaults are in `~/Documents/Obsidian-vaults/` — back those up separately.
- `mpd` log/database/state (`log` alone was 16MB).
- `mpv` `watch_later/` (resume-file spam).
- `*.bak*`, `*.old`, `*~` files (Hyprland/gtk/etc litter these).
- `~/web-project` — skipped for now (630MB, 7 nested git repos, 325MB fonts in hiraeth). Each subproject already has its own `.git`.

## Restore

```sh
# example: restore one app
rsync -a ~/Desktop/apps-backup/configs/kitty/ ~/.config/kitty/
```
