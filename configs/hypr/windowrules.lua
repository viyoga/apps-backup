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
	name = "float-satty",
	match = { class = "^(com\\.gabm\\.satty)$" },
	float = true,
	center = true,
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
	name = "opaque-youtube",
	match = { class = "helium-youtu\\.be__-Default" },
	opaque = true,
})

hl.window_rule({
	name = "opaque-chess",
	match = { class = "helium-www\\.chess\\.com__-Default" },
	opaque = true,
})

hl.window_rule({
	name = "opaque-geoguessr",
	match = { class = "helium-www\\.geoguessr\\.com__multiplayer-Default" },
	opaque = true,
})

hl.window_rule({
	name = "prettyzap-workspace-5",
	match = { class = "^(prettyzap)$" },
	workspace = "5",
})
