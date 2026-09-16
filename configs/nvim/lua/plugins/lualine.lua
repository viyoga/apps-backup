-- Lualine styling that tracks the Noctalia palette: theme is a FUNCTION
-- (rebuilt on every setup incl. ColorScheme), with auto-theme cache bust so
-- mode pill (a) and location (z) refresh too. Sections b→x sit on CursorLine
-- bg; y (progress) links the MoreMsg highlight for an accent fg that follows
-- the palette (both re-resolved live, nothing hardcoded).
local function make_transparent()
  local bar_bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("CursorLine")), "bg#")
  if bar_bg == "" then
    bar_bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#")
  end
  if bar_bg == "" then
    bar_bg = "#0b0d11"
  end
  -- Bust the cached auto theme: lualine.themes.auto resolves to the base16
  -- theme ONCE at first require (a/z/fg frozen to that palette). Clearing it
  -- forces a fresh build from current base16.colors on every setup, so mode
  -- pills (a) and cursor position (z) track palette switches too.
  package.loaded["lualine.themes.auto"] = nil
  local theme = require("lualine.themes.auto")
  local modes = { "normal", "insert", "visual", "replace", "command" }
  for _, mode in ipairs(modes) do
    if theme[mode] then
      if theme[mode].b then theme[mode].b.bg = bar_bg end
      if theme[mode].c then theme[mode].c.bg = bar_bg end
      if theme[mode].x then theme[mode].x.bg = bar_bg end
    end
  end
  if theme.inactive then
    if theme.inactive.b then theme.inactive.b.bg = bar_bg end
    if theme.inactive.c then theme.inactive.c.bg = bar_bg end
    if theme.inactive.x then theme.inactive.x.bg = bar_bg end
  end
  return theme
end

-- CURRENT vim mode. Evaluated per mode at every lualine setup (incl. its own
-- ColorScheme-triggered setup), reading lualine's own freshly built groups —
-- so it follows both palette switches and mode changes with no hardcoding.
-- y (progress) mirrors x (filetype): fg = lualine_c_<mode> fg, the same live
-- group x's text uses. Evaluated per mode at every lualine setup (incl. its
-- own ColorScheme-triggered setup) — follows palette + mode, no hardcoding.
local function progress_color()
  local mode_map = {
    n = "normal",
    i = "insert",
    v = "visual",
    V = "visual",
    ["\22"] = "visual",
    R = "replace",
    c = "command",
    t = "terminal",
  }
  local m = mode_map[vim.fn.mode()] or "normal"
  local x_fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("lualine_c_" .. m)), "fg#")
  if x_fg == "" then
    x_fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "fg#")
  end
  return { fg = x_fg }
end

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
    -- Function theme: re-evaluated on every lualine setup (incl. its own
    -- ColorScheme-triggered setup), so transparency always uses fresh bg.
    opts.options.theme = make_transparent
    opts.sections = {
      -- Section icons via nr2char codepoints (LuaJIT has no \u escapes;
      -- never paste literal PUA glyphs — they arrive as tofu). e62b = vim
      -- logo, f0219 = document, f080 = bar chart, f124 = location arrow.
      lualine_a = {
        { "mode", separator = { left = "", right = "" }, icon = vim.fn.nr2char(0xE62B) },
      },
      lualine_b = { { "filename", path = 3, shorting_target = 0 } },
      lualine_c = {},
      lualine_x = {
        { "filetype", separator = { left = "", right = "" } },
      },
      lualine_y = {
        -- y icon color = x icon color: x's filetype icon is colored by
        -- mini.icons per buffer (mocked devicons path). Read the same source
        -- directly: mini.icons.get returns the hl group for the current file,
        -- use its fg. Evaluated per mode at every setup (fresh groups), so it
        -- tracks palette switches; note it snapshots the CURRENT buffer, a
        -- buffer switch re-syncs on next reload.
        {
          "progress",
          separator = { left = "", right = "" },
          color = progress_color,
          icon = {
            vim.fn.nr2char(0xF080),
            color = function()
              local ok, mi = pcall(require, "mini.icons")
              if ok then
                local _, hl = mi.get("file", vim.fn.expand("%:t"))
                if hl then
                  local fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(hl)), "fg#")
                  if fg ~= "" then
                    return { fg = fg }
                  end
                end
              end
              return {}
            end,
          },
        },
      },
      lualine_z = {
        { "location", separator = { left = "", right = "" }, icon = vim.fn.nr2char(0xEEA9) },
      },
    }
  end,
}
