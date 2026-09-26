 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#141615',
    base01 = '#1f2220',
    base02 = '#292d2a',
    base03 = '#5f6460',
    base04 = '#888c89',
    base05 = '#d8dad8',
    base06 = '#d8dad8',
    base07 = '#d8dad8',
    base08 = '#a35a60',
    base09 = '#606461',
    base0A = '#878b88',
    base0B = '#aeb2af',
    base0C = '#96e9ab',
    base0D = '#96e9ab',
    base0E = '#96e9ab',
    base0F = '#888c89',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#d8dad8',          bg = '#141615' })
  hi('TelescopeBorder',         { fg = '#5f6460',             bg = '#141615' })
  hi('TelescopePromptNormal',   { fg = '#d8dad8',          bg = '#141615' })
  hi('TelescopePromptBorder',   { fg = '#5f6460',             bg = '#141615' })
  hi('TelescopePromptPrefix',   { fg = '#aeb2af',             bg = '#141615' })
  hi('TelescopePromptCounter',  { fg = '#888c89',  bg = '#141615' })
  hi('TelescopePromptTitle',    { fg = '#141615',             bg = '#aeb2af' })
  hi('TelescopePreviewTitle',   { fg = '#141615',             bg = '#878b88' })
  hi('TelescopeResultsTitle',   { fg = '#141615',             bg = '#606461' })
  hi('TelescopeSelection',      { fg = '#d8dad8',          bg = '#292d2a' })
  hi('TelescopeSelectionCaret', { fg = '#aeb2af',             bg = '#292d2a' })
  hi('TelescopeMatching',       { fg = '#aeb2af',             bold = true })

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
