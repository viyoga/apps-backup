local function get_bg()
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg")
end

local function make_transparent()
  local bg = get_bg()
  local theme = require("lualine.themes.auto")
  local modes = { "normal", "insert", "visual", "replace", "command" }
  for _, mode in ipairs(modes) do
    if theme[mode] then
      if theme[mode].b then theme[mode].b.bg = bg end
      if theme[mode].c then theme[mode].c.bg = bg end
      if theme[mode].x then theme[mode].x.bg = bg end
    end
  end
  if theme.inactive then
    if theme.inactive.b then theme.inactive.b.bg = bg end
    if theme.inactive.c then theme.inactive.c.bg = bg end
    if theme.inactive.x then theme.inactive.x.bg = bg end
  end
  return theme
end

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
    opts.options.theme = make_transparent()
    opts.sections = {
      lualine_a = {
        { "mode", separator = { left = "", right = "" } },
      },
      lualine_b = { { "filename", path = 3, shorting_target = 0 } },
      lualine_c = {},
      lualine_x = {
        { "filetype", separator = { left = "", right = "" } },
      },
      lualine_y = {
        { "progress", separator = { left = "", right = "" } },
      },
      lualine_z = {
        { "location", separator = { left = "", right = "" } },
      },
    }
  end,
}
