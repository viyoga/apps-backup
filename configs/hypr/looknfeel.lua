require("colors")

-- Glass persistence: Hyprland re-evaluates this file whenever Noctalia rewrites
-- noctalia.lua (wallpaper/theme change), which would stomp runtime-only
-- opacities and flip everything back to glass. Reading the persisted toggle
-- state here makes every re-eval converge to the mode chosen with Alt+;
-- (scripts/glass-toggle.sh writes ~/.cache/hypr-glass-mode: "on" or "off").
local glass_on = (function()
	local f = io.open(os.getenv("HOME") .. "/.cache/hypr-glass-mode", "r")
	if not f then
		return false
	end
	local v = f:read("*l") or ""
	f:close()
	return v == "on"
end)()

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
		active_opacity = glass_on and 0.78 or 1.0,
		inactive_opacity = glass_on and 0.8 or 1.0,
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
			enabled = glass_on,
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
