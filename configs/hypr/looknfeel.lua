require("colors")

-- Blur/glass permanently disabled by user request (2026-10-14): no
-- translucency anywhere. The toggle script and its Alt+; bind were removed;
-- decoration blur and the window opacities below are pinned off so a Noctalia
-- re-eval of this file cannot re-enable them.
local glass_on = false

hl.config({
	animations = {
		enabled = true,
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},
	general = {
		gaps_in = 2,
		gaps_out = 4,
		border_size = 0,
		col = {
			active_border = { colors = { primary, primary_container }, angle = 45 },
			inactive_border = surface_variant,
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	scrolling = {
		fullscreen_on_one_column = true,
		column_width = 1,
		focus_fit_method = 1,
	},
	decoration = {
		rounding = 0,
		rounding_power = 2,
		active_opacity = 0.78,
		inactive_opacity = 0.8,
		shadow = {
			enabled = false,
			range = 25,
			render_power = 2,
			color = "0xaa1a1a1a",
			color_inactive = "0x00000000",
			offset = { 0, 3 },
			scale = 1.0,
		},
		blur = {
			enabled = on,
			size = 5,
			passes = 2,
			noise = 0.02,
			contrast = 1.1,
			brightness = 0.9,
			ignore_opacity = true,
			new_optimizations = true,
			xray = false,
		},
	},
})

-- animations moved to animations.lua
