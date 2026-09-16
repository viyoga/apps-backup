# ⌨️ Neovim Keybindings Cheat Sheet

All bindings use **`<Space>`** as the leader key.

---

## 🔍 Finding & Opening Files

| Shortcut | Action |
|---|---|
| `<Space>` + `h` | **Search ENTIRE PC** (Home, `/mnt/hdd`, external drives, hidden files) |
| `<Space>` + `<Space>` | **Search Current Project / Folder** (Fuzzy find files in current directory) |
| `<Space>` + `e` | **File Tree Sidebar** (Opens in the folder of your current open file) |
| `<Space>` + `E` | **File Tree Sidebar (Root)** (Opens at project/workspace root) |
| `<Space>` + `f` `f` | Find files in current project |
| `<Space>` + `f` `r` | Open recent files history |
| `<Space>` + `/` | Search text inside files (Live Grep) |
| `<Space>` + `,` | Show list of currently open files/buffers |

---

## 📂 File Tree (Explorer) Navigation (`<Space>` + `e`)

When inside the left sidebar explorer:

| Key | Action |
|---|---|
| `<BS>` (Backspace) or `-` | **Go UP** to parent folder (navigate outside current dir) |
| `Enter` or `l` | Open file / expand folder |
| `h` | Collapse folder |
| `a` | Create new file (end with `/` to create a directory) |
| `d` | Delete file / folder |
| `r` | Rename file / folder |
| `c` | Copy file / folder |
| `m` | Move file / folder |
| `H` | Toggle hidden dotfiles on/off |
| `Esc` or `q` | Close file tree |

---

## 📑 Switching Between Open Files (Tabs / Buffers)

| Shortcut | Action |
|---|---|
| `<Space>` + `d` *(or `<Space>` + `x`)* | **Close / Delete current file buffer (`:bd`)** |
| `Shift` + `l` (or `]b`) | Switch to **Next** open file (tab to the right) |
| `Shift` + `h` (or `[b`) | Switch to **Previous** open file (tab to the left) |
| `<Space>` + `b` `b` | Switch back and forth between **last two visited files** |
| `<Space>` + `,` | Search and select from open buffers |

---

## 📜 Scrolling (Centered)

| Shortcut | Action |
|---|---|
| `Ctrl` + `d` | Scroll **down** half-page (moves cursor to middle first with `zz`) |
| `Ctrl` + `u` | Scroll **up** half-page (moves cursor to middle first with `zz`) |

---

## 🪟 Window Splits Navigation

| Shortcut | Action |
|---|---|
| `Ctrl` + `h` | Move focus to **Left** window |
| `Ctrl` + `l` | Move focus to **Right** window |
| `Ctrl` + `j` | Move focus to **Bottom** window |
| `Ctrl` + `k` | Move focus to **Top** window |
| `<Space>` + `\|` | Split window **vertically** (side-by-side) |
| `<Space>` + `-` | Split window **horizontally** (stacked) |
| `<Space>` + `w` `d` | Close current split window |

---

## 🚀 Dashboard Shortcuts (When first opening Neovim)

| Key | Action |
|---|---|
| `d` | Search dotfiles & home folder (with hidden files) |
| `f` | Search files in `~` |
| `c` | Search `~/.config` files |
| `h` | Search `~/.config/hypr` files |
| `n` | Create a new blank file |
| `q` | Quit Neovim |
