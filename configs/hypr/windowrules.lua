hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = { class = "^$", title = "^$", xwayland = true, float = true },
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "solid-gtk-file-picker",
	match = { class = "^(xdg-desktop-portal-gtk)$" },
	opaque = true,
	size = "1150 750",
	center = true,
})

hl.window_rule({
	name = "float-imv",
	match = { class = "^(imv)$" },
	float = true,
	center = true,
	opaque = true,
})

hl.window_rule({
	name = "waydroid",
	match = { class = "^(Waydroid)$" },
	fullscreen = true,
})

hl.window_rule({
	name = "float-localsend",
	match = { class = "^(org\\.localsend\\.localsend_app|localsend)$" },
	float = true,
	center = true,
	size = "500 750",
})

hl.window_rule({
	name = "float-dict",
	match = { class = "^(dict)$" },
	float = true,
	center = true,
	size = "650 550",
})

hl.window_rule({
	name = "float-obsidian",
	match = { class = "obsidian" },
	float = true,
	center = true,
	size = "1150 750",
})

hl.window_rule({
	name = "float-cmdrunner",
	match = { class = "^(kitty-cmdrunner)$" },
	float = true,
	center = true,
	size = "1300 700",
})

hl.window_rule({
	name = "opaque-brave-always",
	match = { class = "^brave-.*" },
	opaque = true,
})

hl.window_rule({
	name = "opaque-qutebrowser",
	match = { class = "^(org\\.qutebrowser.*|qutebrowser.*)$" },
	opaque = true,
})

hl.window_rule({
	name = "opaque-helium",
	match = { class = "^helium.*" },
	opaque = true,
})

hl.window_rule({
	name = "float-auth-dialogs",
	match = { class = "^(org\\.kde\\.kwalletd.*|kwalletd.*|pinentry.*|gcr-prompter|polkit.*)$" },
	float = true,
	center = true,
})

