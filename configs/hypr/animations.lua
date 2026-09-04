---@diagnostic disable: undefined-global
-- animations.lua — split from looknfeel.lua
-- Two profiles: slide (default/bounce) and fade (for rolling/scrolling)
-- Toggle via SUPER+SHIFT+;  ->  ~/.config/hypr/scripts/anim-toggle.sh
-- State persisted in ~/.cache/hypr-animations-mode

-- curves (shared)
hl.curve("easeOut", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })
hl.curve("easeIn", { type = "bezier", points = { { 0.4, 0 }, { 1, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1 } } })
hl.curve("bounce", { type = "bezier", points = { { 0.22, 1 }, { 0.18, 1.04 } } })

local M = {}
local current_mode = "slide"

function M.apply_slide()
	current_mode = "slide"
	-- SLIDE profile — original (leave as-is)
	hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
	hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "bounce", style = "slide" })
	hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "bounce", style = "slide" })
	hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "easeOut", style = "popin 85%" })
	hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "easeIn", style = "popin 85%" })

	hl.animation({ leaf = "fade", enabled = true, speed = 3.5, bezier = "smooth" })
	hl.animation({ leaf = "fadeIn", enabled = true, speed = 2.5, bezier = "smooth" })
	hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.5, bezier = "smooth" })

	hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "easeOut" })

	hl.animation({ leaf = "layers", enabled = true, speed = 3.5, bezier = "easeOut" })
	hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "easeOut", style = "fade" })
	hl.animation({ leaf = "layersOut", enabled = true, speed = 2.5, bezier = "easeIn", style = "fade" })

	hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "bounce", style = "slide" })
end

function M.apply_fade()
	current_mode = "fade"
	-- FADE profile — window change + workspace change faded (for rolling/scrolling)
	-- SUPER+, / SUPER+. (move -col / +col) will now fade instead of slide
	-- windows only supports slide/popin/gnomed, so use minimal popin + opacity fade
	hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
	hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "smooth", style = "popin 90%" })
	hl.animation({ leaf = "windowsMove", enabled = false })
	hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "easeOut", style = "popin 90%" })
	hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "easeIn", style = "popin 90%" })

	hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "smooth" })
	hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "smooth" })
	hl.animation({ leaf = "fadeOut", enabled = true, speed = 3, bezier = "smooth" })
	hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 4, bezier = "smooth" })

	hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "easeOut" })

	hl.animation({ leaf = "layers", enabled = true, speed = 3.5, bezier = "easeOut" })
	hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "easeOut", style = "fade" })
	hl.animation({ leaf = "layersOut", enabled = true, speed = 2.5, bezier = "easeIn", style = "fade" })

	hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "smooth", style = "fade" })
end

function M.toggle()
	if current_mode == "slide" then
		M.apply_fade()
	else
		M.apply_slide()
	end
	return current_mode
end

-- expose current_mode getter for script diagnostics
function M.get_mode()
	return current_mode
end

-- on initial load: restore saved preference if any
do
	local state_file = os.getenv("HOME") .. "/.cache/hypr-animations-mode"
	local f = io.open(state_file, "r")
	local saved = f and f:read("*l") or nil
	if f then f:close() end
	if saved == "fade" then
		M.apply_fade()
		current_mode = "fade"
	else
		M.apply_slide()
		current_mode = "slide"
	end
end

return M
