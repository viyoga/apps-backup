 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#231a23',
    base01 = '#3b2b3b',
    base02 = '#362636',
    base03 = '#726372',
    base04 = '#b6afb6',
    base05 = '#f3f2f3',
    base06 = '#f3f2f3',
    base07 = '#f3f2f3',
    base08 = '#fd4663',
    base09 = '#dcaead',
    base0A = '#dfaac4',
    base0B = '#e5a4e4',
    base0C = '#d9a7a6',
    base0D = '#dea1dd',
    base0E = '#dca2bf',
    base0F = '#b6afb6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f3f2f3',          bg = '#231a23' })
  hi('TelescopeBorder',         { fg = '#726372',             bg = '#231a23' })
  hi('TelescopePromptNormal',   { fg = '#f3f2f3',          bg = '#231a23' })
  hi('TelescopePromptBorder',   { fg = '#726372',             bg = '#231a23' })
  hi('TelescopePromptPrefix',   { fg = '#e5a4e4',             bg = '#231a23' })
  hi('TelescopePromptCounter',  { fg = '#b6afb6',  bg = '#231a23' })
  hi('TelescopePromptTitle',    { fg = '#231a23',             bg = '#e5a4e4' })
  hi('TelescopePreviewTitle',   { fg = '#231a23',             bg = '#dfaac4' })
  hi('TelescopeResultsTitle',   { fg = '#231a23',             bg = '#dcaead' })
  hi('TelescopeSelection',      { fg = '#f3f2f3',          bg = '#362636' })
  hi('TelescopeSelectionCaret', { fg = '#e5a4e4',             bg = '#362636' })
  hi('TelescopeMatching',       { fg = '#e5a4e4',             bold = true })

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
