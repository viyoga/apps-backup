-- theme-watch: automatically apply theme/flavor changes without restarting Yazi.
--
-- Yazi parses `theme.toml` and the selected flavor once at startup, but ships an
-- `app:theme` action that re-reads them from disk at runtime. This plugin closes
-- the last gap by watching those files and emitting `app:theme` when they change.
--
-- Usage (init.lua):
--   require("theme-watch"):setup({ interval = 1.0 })

local M = {}

local function read(path)
	local f = io.open(path, "rb")
	if not f then
		return nil
	end
	local s = f:read("*a")
	f:close()
	return s
end

local function flavor_paths(theme)
	local paths = {}
	for _, key in ipairs({ "dark", "light" }) do
		local name = theme and theme:match("\n%s*" .. key .. '%s*=%s*"([^"]+)"')
		if not name then
			name = theme and theme:match("^%s*" .. key .. '%s*=%s*"([^"]+)"')
		end
		if name and name ~= "" then
			paths[#paths + 1] = rt.path.config_dir .. "/flavors/" .. name .. ".yazi/flavor.toml"
		end
	end
	return paths
end

function M.setup(opts)
	opts = opts or {}
	local interval = opts.interval or 1.0
	local theme_file = rt.path.config_dir .. "/theme.toml"

	ya.async(function()
		local last = {}
		local function tracked()
			local paths = { theme_file }
			for _, p in ipairs(flavor_paths(last[theme_file])) do
				paths[#paths + 1] = p
			end
			return paths
		end

		last[theme_file] = read(theme_file)
		for _, p in ipairs(tracked()) do
			last[p] = read(p)
		end

		while true do
			ya.sleep(interval)

			local changed = false
			for _, p in ipairs(tracked()) do
				local now = read(p)
				if now ~= nil and last[p] ~= nil and now ~= last[p] then
					changed = true
				end
			end
			if not changed then
				goto continue
			end

			-- Let atomic-ish writers settle, then cache the final content.
			ya.sleep(0.2)
			last[theme_file] = read(theme_file) or last[theme_file]
			for _, p in ipairs(tracked()) do
				last[p] = read(p) or last[p]
			end
			ya.emit("app:theme", {})

			::continue::
		end
	end)
end

return M
