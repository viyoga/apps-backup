require("colors")

hl.config({
	animations = {
		enabled = true,
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},
	general = {
		gaps_in = 5,
		gaps_out = 8,
		border_size = 0,
		col = {
			active_border = { colors = { primary, primary_container }, angle = 45 },
			inactive_border = surface_variant,
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "master",
	},
	scrolling = {
		fullscreen_on_one_column = true,
		column_width = 0.8,
		focus_fit_method = 1,
	},
	decoration = {
		rounding = 0,
		rounding_power = 2,
		active_opacity = 1,
		inactive_opacity = 1,
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
			enabled = true,
			size = 8,
			passes = 3,
			noise = 0.02,
			contrast = 1.1,
			brightness = 0.9,
			ignore_opacity = true,
			new_optimizations = true,
			xray = false,
		},
	},
})

-- animations moved to animations.lua (slide vs fade profiles)
