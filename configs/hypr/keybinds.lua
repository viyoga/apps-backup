---@diagnostic disable: undefined-global
local mainMod = "SUPER"

-- These shadow the globals from hyprland.lua to match original keybinds.conf
local terminal = "kitty"
local fileManager = "nautilus"
local browser = "brave-origin-nightly"

-- Apps & Launchers
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + backslash", hl.dsp.exec_cmd("kitty -e opencode2 -c"))
hl.bind(mainMod .. " +SHIFT +backslash", hl.dsp.exec_cmd("kitty -e opencode -c"))
hl.bind("ALT + backslash", hl.dsp.exec_cmd(terminal .. " -e agy"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("obsidian"))
hl.bind(
	mainMod .. " + SHIFT + N",
	hl.dsp.exec_cmd("kitty -e tuxedo /home/kabir/Documents/Obsidian-vaults/kittybox/todo.md")
)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("kitty -e btop"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("spotify"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("kitty -e rmpc"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("kitty -o font_size=21 -e typer"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("vesktop"))
hl.bind(mainMod .. " + End", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("kitty -e cliamp"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("qutebrowser"))

hl.bind("ALT + E", hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind("ALT + N", hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind("ALT + S", hl.dsp.exec_cmd("sung"))
hl.bind("ALT + M", hl.dsp.exec_cmd("sonora"))
hl.bind("ALT + W", hl.dsp.exec_cmd("zapfast"))
hl.bind("ALT + D", hl.dsp.exec_cmd("serein-maple"))

-- WebApps
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(browser .. " --app=https://www.geoguessr.com/multiplayer"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/prettyzap-toggle.sh"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(browser .. " --app=https://www.monkeytype.com"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(browser .. " --app=https://www.twitch.tv/finbarricade"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(browser .. " --app=https://www.chess.com"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(browser .. " --app=https://claude.ai"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd(browser .. " --app=https://youtu.be"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd(browser .. " --app=https://github.com"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(browser .. " --app=https://reddit.com"))

-- Plugins
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("~/.config/hypr/scripts/screen-rec.sh with"))
hl.bind(mainMod .. " + SHIFT + F1", hl.dsp.exec_cmd("~/.config/hypr/scripts/screen-rec.sh without"))
hl.bind(mainMod .. " + semicolon", hl.dsp.exec_cmd("~/.config/hypr/scripts/layout-toggle.sh"))
hl.bind("ALT + semicolon", hl.dsp.exec_cmd("~/.config/hypr/scripts/blur-toggle.sh"))
hl.bind(mainMod .. " + SHIFT + semicolon", hl.dsp.exec_cmd("~/.config/hypr/scripts/anim-toggle.sh"))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("noctalia msg panel-toggle hiraeth/noctavibes:panel"))
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("noctalia msg panel-toggle samuelskovbakke/calculator-plus:panel"))
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("noctalia msg panel-toggle rylos/syncthing:panel"))
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("noctalia msg panel-toggle alexmnrs/github-activity:calendar"))
hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd("noctalia msg panel-toggle ahmedhossamdev/sticky-notes:panel"))

-- Window Management
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/xdm-toggle.sh"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("pkill -x xdm-app"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("~/.config/hypr/scripts/float-center.sh"))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Cycle windows
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next())

-- Menus & Scripts
hl.bind(mainMod .. " + i", hl.dsp.exec_cmd("noctalia msg settings-toggle"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center media"))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + CTRL + space", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center notifications"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(mainMod .. " + apostrophe", hl.dsp.exec_cmd("noctalia msg panel-open launcher /emo"))
hl.bind(mainMod .. " + SHIFT + apostrophe", hl.dsp.exec_cmd("noctalia msg panel-open launcher /kao"))
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd('noctalia msg panel-toggle launcher "/web"'))
hl.bind("ALT  + slash", hl.dsp.exec_cmd('noctalia msg panel-toggle launcher "/"'))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center audio"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center network"))

-- Scrolling Layout
hl.bind(mainMod .. " + comma", hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + CTRL + comma", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + CTRL + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("colresize -0.1"))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("colresize +0.1"))

-- Screenshots And Other Tools
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind("Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("~/.config/hypr/scripts/colorpicker.sh"))
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd("~/.config/hypr/scripts/textshot.sh"))
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd("noctalia msg panel-toggle noctalia/wallhaven:browser"))
hl.bind(mainMod .. " + F10", hl.dsp.exec_cmd("~/.config/hypr/scripts/readtext.sh"))

-- Workspaces
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Audio (Noctalia OSD)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up 5"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down 5"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"), { repeating = true, locked = true })

-- Brightness (Noctalia OSD)
hl.bind("ALT + UP", hl.dsp.exec_cmd("noctalia msg brightness-up 5"))
hl.bind("ALT + DOWN", hl.dsp.exec_cmd("noctalia msg brightness-down 5"))

-- System
hl.bind("ALT + SHIFT + S", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind("ALT + SHIFT + R", hl.dsp.exec_cmd("noctalia msg session reboot"))
hl.bind("ALT + SHIFT + L", hl.dsp.exec_cmd("noctalia msg session lock"))
hl.bind("ALT + SHIFT + Q", hl.dsp.exec_cmd("noctalia msg session logout"))
