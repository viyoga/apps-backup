 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#121110',
    base01 = '#1a1816',
    base02 = '#25221f',
    base03 = '#63605c',
    base04 = '#e2d1c1',
    base05 = '#e2d1c1',
    base06 = '#e2d1c1',
    base07 = '#e2d1c1',
    base08 = '#c97a63',
    base09 = '#d9b6aa',
    base0A = '#d99b78',
    base0B = '#d4ab7b',
    base0C = '#e9ab96',
    base0D = '#e9c396',
    base0E = '#e9b496',
    base0F = '#e2d1c1',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e2d1c1',          bg = '#121110' })
  hi('TelescopeBorder',         { fg = '#63605c',             bg = '#121110' })
  hi('TelescopePromptNormal',   { fg = '#e2d1c1',          bg = '#121110' })
  hi('TelescopePromptBorder',   { fg = '#63605c',             bg = '#121110' })
  hi('TelescopePromptPrefix',   { fg = '#d4ab7b',             bg = '#121110' })
  hi('TelescopePromptCounter',  { fg = '#e2d1c1',  bg = '#121110' })
  hi('TelescopePromptTitle',    { fg = '#121110',             bg = '#d4ab7b' })
  hi('TelescopePreviewTitle',   { fg = '#121110',             bg = '#d99b78' })
  hi('TelescopeResultsTitle',   { fg = '#121110',             bg = '#d9b6aa' })
  hi('TelescopeSelection',      { fg = '#e2d1c1',          bg = '#25221f' })
  hi('TelescopeSelectionCaret', { fg = '#d4ab7b',             bg = '#25221f' })
  hi('TelescopeMatching',       { fg = '#d4ab7b',             bold = true })

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
