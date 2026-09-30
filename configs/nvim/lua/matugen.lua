 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1a2223',
    base01 = '#2b383b',
    base02 = '#263336',
    base03 = '#606d70',
    base04 = '#afb5b6',
    base05 = '#f2f3f3',
    base06 = '#f2f3f3',
    base07 = '#f2f3f3',
    base08 = '#fd4663',
    base09 = '#8070c2',
    base0A = '#6b87c7',
    base0B = '#75c3d7',
    base0C = '#b0a6d9',
    base0D = '#a1d1de',
    base0E = '#a3b4dc',
    base0F = '#afb5b6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f3f3',          bg = '#1a2223' })
  hi('TelescopeBorder',         { fg = '#606d70',             bg = '#1a2223' })
  hi('TelescopePromptNormal',   { fg = '#f2f3f3',          bg = '#1a2223' })
  hi('TelescopePromptBorder',   { fg = '#606d70',             bg = '#1a2223' })
  hi('TelescopePromptPrefix',   { fg = '#75c3d7',             bg = '#1a2223' })
  hi('TelescopePromptCounter',  { fg = '#afb5b6',  bg = '#1a2223' })
  hi('TelescopePromptTitle',    { fg = '#1a2223',             bg = '#75c3d7' })
  hi('TelescopePreviewTitle',   { fg = '#1a2223',             bg = '#6b87c7' })
  hi('TelescopeResultsTitle',   { fg = '#1a2223',             bg = '#8070c2' })
  hi('TelescopeSelection',      { fg = '#f2f3f3',          bg = '#263336' })
  hi('TelescopeSelectionCaret', { fg = '#75c3d7',             bg = '#263336' })
  hi('TelescopeMatching',       { fg = '#75c3d7',             bold = true })

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
