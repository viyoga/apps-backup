vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "LazySpecial", { link = "Special", default = true })
		local ok, noice_hl = pcall(require, "noice.text.highlight")
		if ok then
			noice_hl.hl = {}
			noice_hl.hl_attrs = {}
		end
	end,
})

return {
	"snacks.nvim",
	keys = {
		-- Open explorer at the current file's directory
		{
			"<leader>e",
			function()
				Snacks.explorer({ cwd = vim.fn.expand("%:p:h") })
			end,
			desc = "Explorer (File Dir)",
		},
	},
	opts = {
		dashboard = {
			width = 50,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{
					align = "center",
					padding = { 0, 1 },
					text = {
						{ "Until we turn to dust, meow ", hl = "footer" },
						{ "(ﾐゝᆽ╹ﾐ)", hl = "special" },
					},
				},
			},
			preset = {
				header = [[
 ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
         ░    ░  ░    ░ ░        ░   ░         ░   
                                ░                  ]],
				keys = {
					{ icon = " ", key = "f", desc = "~/Home", action = ":lua Snacks.dashboard.pick('files')" },
					{
						icon = " ",
						key = "c",
						desc = "~/nvim",
						action = ":lua Snacks.dashboard.pick('files', {cwd = '~/.config'})",
					},
					{
						icon = "󱤇 ",
						key = "d",
						desc = "~/dotfiles",
						action = ":lua Snacks.dashboard.pick('files', {cwd = '~', hidden = true})",
					},
					{
						icon = " ",
						key = "h",
						desc = "~/hypr",
						action = ":lua Snacks.dashboard.pick('files', {cwd = '~/.config/hypr'})",
					},
					{ icon = " ", key = "n", desc = "touch.new ", action = ":ene | startinsert" },

					{ icon = "󰒲 ", key = "l", desc = "lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "quit", action = ":qa" },
				},
			},
		},
	},
}
