 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#141211',
    base01 = '#1c1e1e',
    base02 = '#262929',
    base03 = '#5a6266',
    base04 = '#b19f8d',
    base05 = '#b19f8d',
    base06 = '#b19f8d',
    base07 = '#b19f8d',
    base08 = '#a64616',
    base09 = '#9f6e53',
    base0A = '#597885',
    base0B = '#cbaa7f',
    base0C = '#e9b396',
    base0D = '#e9c596',
    base0E = '#96d0e9',
    base0F = '#b19f8d',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#b19f8d',          bg = '#141211' })
  hi('TelescopeBorder',         { fg = '#5a6266',             bg = '#141211' })
  hi('TelescopePromptNormal',   { fg = '#b19f8d',          bg = '#141211' })
  hi('TelescopePromptBorder',   { fg = '#5a6266',             bg = '#141211' })
  hi('TelescopePromptPrefix',   { fg = '#cbaa7f',             bg = '#141211' })
  hi('TelescopePromptCounter',  { fg = '#b19f8d',  bg = '#141211' })
  hi('TelescopePromptTitle',    { fg = '#141211',             bg = '#cbaa7f' })
  hi('TelescopePreviewTitle',   { fg = '#141211',             bg = '#597885' })
  hi('TelescopeResultsTitle',   { fg = '#141211',             bg = '#9f6e53' })
  hi('TelescopeSelection',      { fg = '#b19f8d',          bg = '#262929' })
  hi('TelescopeSelectionCaret', { fg = '#cbaa7f',             bg = '#262929' })
  hi('TelescopeMatching',       { fg = '#cbaa7f',             bold = true })

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
