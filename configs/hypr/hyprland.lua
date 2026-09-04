require("colors")
require("autostart")
require("input")
require("looknfeel")
require("animations")
require("keybinds")
require("windowrules")
require("envs")

hl.monitor({
	output = "",
	mode = "1920x1080@60",
	position = "auto",
	scale = "auto",
})

-- Noctalia blur layer rules
hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

-- Persistent workspaces for Noctalia workspace widget
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1", persistent = true })


-- For Noctalia Color templates
require("noctalia").apply_theme()
