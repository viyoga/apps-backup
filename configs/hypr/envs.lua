hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "21")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "21")
hl.env("ADW_DISABLE_PORTAL", "1")
hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GSK_RENDERER", "gl")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("TERMINAL", "kitty")
hl.env("XDG_CONFIG_HOME", "/home/kabir/.config")
hl.env("SHELL", "/usr/bin/zsh")

hl.config({
	render = {
		direct_scanout = 0,
	},
})
