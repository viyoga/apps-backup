 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#231f1a',
    base01 = '#3b342b',
    base02 = '#362f26',
    base03 = '#706960',
    base04 = '#b6b3af',
    base05 = '#f3f2f2',
    base06 = '#f3f2f2',
    base07 = '#f3f2f2',
    base08 = '#fd4663',
    base09 = '#97b181',
    base0A = '#afb181',
    base0B = '#c1a88b',
    base0C = '#bed0af',
    base0D = '#d3c1ac',
    base0E = '#ced0af',
    base0F = '#b6b3af',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f3f2f2',          bg = '#231f1a' })
  hi('TelescopeBorder',         { fg = '#706960',             bg = '#231f1a' })
  hi('TelescopePromptNormal',   { fg = '#f3f2f2',          bg = '#231f1a' })
  hi('TelescopePromptBorder',   { fg = '#706960',             bg = '#231f1a' })
  hi('TelescopePromptPrefix',   { fg = '#c1a88b',             bg = '#231f1a' })
  hi('TelescopePromptCounter',  { fg = '#b6b3af',  bg = '#231f1a' })
  hi('TelescopePromptTitle',    { fg = '#231f1a',             bg = '#c1a88b' })
  hi('TelescopePreviewTitle',   { fg = '#231f1a',             bg = '#afb181' })
  hi('TelescopeResultsTitle',   { fg = '#231f1a',             bg = '#97b181' })
  hi('TelescopeSelection',      { fg = '#f3f2f2',          bg = '#362f26' })
  hi('TelescopeSelectionCaret', { fg = '#c1a88b',             bg = '#362f26' })
  hi('TelescopeMatching',       { fg = '#c1a88b',             bold = true })

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
