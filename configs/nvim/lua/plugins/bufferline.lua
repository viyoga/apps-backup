-- Bufferline follows the Noctalia palette via live highlight-group refs
-- (Normal/CursorLine/Visual/Comment/String/ErrorMsg = base00/01/02/03/0B/08),
-- re-resolved by bufferline on every ColorScheme event. No manual sync.
local ref = function(group, attr)
  return { highlight = group, attribute = attr }
end

local bg = ref("Normal", "bg")
local bg1 = ref("CursorLine", "bg")
local bg2 = ref("Visual", "bg")
local muted = ref("Comment", "fg")
local fg = ref("Normal", "fg")
local accent = ref("String", "fg")
local err = ref("ErrorMsg", "fg")

return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      separator_style = "thin",
      indicator = { style = "none" },
    },
    highlights = {
      -- The fill area (background of the whole tab bar)
      fill                = { bg = bg1 },

      -- Inactive tabs
      background          = { fg = muted, bg = bg1 },
      tab                 = { fg = muted, bg = bg1 },
      tab_close           = { fg = muted, bg = bg1 },
      close_button        = { fg = muted, bg = bg1 },

      -- Active / selected tab
      buffer_selected     = { fg = fg,     bg = bg,  bold = true },
      tab_selected        = { fg = accent, bg = bg,  bold = true },
      close_button_selected = { fg = muted, bg = bg },

      -- Visible but not selected (split windows)
      buffer_visible      = { fg = muted, bg = bg1 },
      close_button_visible = { fg = muted, bg = bg1 },

      -- Separators
      separator           = { fg = bg,    bg = bg1 },
      separator_selected  = { fg = bg,    bg = bg },
      separator_visible   = { fg = bg1,   bg = bg1 },

      -- Diagnostic indicators
      error               = { fg = muted, bg = bg1 },
      error_selected      = { fg = err,    bg = bg,  bold = true },
      warning             = { fg = muted, bg = bg1 },
      warning_selected    = { fg = accent, bg = bg,  bold = true },
      info                = { fg = muted, bg = bg1 },
      info_selected       = { fg = accent, bg = bg,  bold = true },
      hint                = { fg = muted, bg = bg1 },
      hint_selected       = { fg = accent, bg = bg,  bold = true },

      -- Modified indicator
      modified            = { fg = accent, bg = bg1 },
      modified_selected   = { fg = accent, bg = bg },
      modified_visible    = { fg = accent, bg = bg1 },

      -- Numbers
      numbers             = { fg = muted, bg = bg1 },
      numbers_selected    = { fg = accent, bg = bg,  bold = true },
      numbers_visible     = { fg = muted, bg = bg1 },

      -- Pinned
      duplicate_selected  = { fg = accent, bg = bg,  italic = true },
      duplicate_visible   = { fg = muted,  bg = bg1, italic = true },
      duplicate           = { fg = muted,  bg = bg1, italic = true },
    },
  },
}
