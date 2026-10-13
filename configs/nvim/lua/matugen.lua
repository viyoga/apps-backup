 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#171a1c',
    base01 = '#222629',
    base02 = '#2b3034',
    base03 = '#5f666c',
    base04 = '#828c91',
    base05 = '#d5dadb',
    base06 = '#d5dadb',
    base07 = '#d5dadb',
    base08 = '#cc6674',
    base09 = '#b85562',
    base0A = '#c9a96e',
    base0B = '#a0b2bc',
    base0C = '#e996a1',
    base0D = '#96cbe9',
    base0E = '#e9cc96',
    base0F = '#828c91',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#d5dadb',          bg = '#171a1c' })
  hi('TelescopeBorder',         { fg = '#5f666c',             bg = '#171a1c' })
  hi('TelescopePromptNormal',   { fg = '#d5dadb',          bg = '#171a1c' })
  hi('TelescopePromptBorder',   { fg = '#5f666c',             bg = '#171a1c' })
  hi('TelescopePromptPrefix',   { fg = '#a0b2bc',             bg = '#171a1c' })
  hi('TelescopePromptCounter',  { fg = '#828c91',  bg = '#171a1c' })
  hi('TelescopePromptTitle',    { fg = '#171a1c',             bg = '#a0b2bc' })
  hi('TelescopePreviewTitle',   { fg = '#171a1c',             bg = '#c9a96e' })
  hi('TelescopeResultsTitle',   { fg = '#171a1c',             bg = '#b85562' })
  hi('TelescopeSelection',      { fg = '#d5dadb',          bg = '#2b3034' })
  hi('TelescopeSelectionCaret', { fg = '#a0b2bc',             bg = '#2b3034' })
  hi('TelescopeMatching',       { fg = '#a0b2bc',             bold = true })

  hi('Delimiter',               { link = 'Comment' })
  hi('SpecialChar',             { link = 'Comment' })
  hi('TSPunctDelimiter',        { link = 'Comment' })
  hi('TSPunctSpecial',          { link = 'Comment' })
  hi('TSAnnotation',            { link = 'Comment' })
  hi('TSTagDelimiter',          { link = 'Comment' })

end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
