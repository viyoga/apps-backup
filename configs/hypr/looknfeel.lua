require("colors")

-- Glass persistence: Hyprland re-evaluates this file whenever Noctalia
-- rewrites noctalia.lua (theme/wallpaper change), stomping runtime-only
-- opacities. Reading the toggle state here makes every re-eval converge to
-- the persisted mode. Toggle with Alt+; (blur-toggle.sh).
local glass_on = (function()
	local f = io.open(os.getenv("HOME") .. "/.cache/hypr-blur-mode", "r")
	if not f then
		return false
	end
	local v = f:read("*l") or ""
	f:close()
	return v == "blur" or v == "glass"
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
		gaps_in = 5,
		gaps_out = 8,
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
		active_opacity = glass_on and 0.87 or 1,
		inactive_opacity = glass_on and 0.82 or 1,
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
