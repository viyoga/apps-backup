 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1f1819',
    base01 = '#291f20',
    base02 = '#352829',
    base03 = '#795f60',
    base04 = '#b5a6a3',
    base05 = '#f5ece8',
    base06 = '#f5ece8',
    base07 = '#f5ece8',
    base08 = '#ff2d6f',
    base09 = '#f59e0b',
    base0A = '#e0875a',
    base0B = '#ff382e',
    base0C = '#face85',
    base0D = '#ff8680',
    base0E = '#ebb194',
    base0F = '#b5a6a3',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f5ece8',          bg = '#1f1819' })
  hi('TelescopeBorder',         { fg = '#795f60',             bg = '#1f1819' })
  hi('TelescopePromptNormal',   { fg = '#f5ece8',          bg = '#1f1819' })
  hi('TelescopePromptBorder',   { fg = '#795f60',             bg = '#1f1819' })
  hi('TelescopePromptPrefix',   { fg = '#ff382e',             bg = '#1f1819' })
  hi('TelescopePromptCounter',  { fg = '#b5a6a3',  bg = '#1f1819' })
  hi('TelescopePromptTitle',    { fg = '#1f1819',             bg = '#ff382e' })
  hi('TelescopePreviewTitle',   { fg = '#1f1819',             bg = '#e0875a' })
  hi('TelescopeResultsTitle',   { fg = '#1f1819',             bg = '#f59e0b' })
  hi('TelescopeSelection',      { fg = '#f5ece8',          bg = '#352829' })
  hi('TelescopeSelectionCaret', { fg = '#ff382e',             bg = '#352829' })
  hi('TelescopeMatching',       { fg = '#ff382e',             bold = true })

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
