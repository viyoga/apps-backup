 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#23201a',
    base01 = '#3b362b',
    base02 = '#363126',
    base03 = '#6f6a5f',
    base04 = '#b6b4af',
    base05 = '#f3f2f2',
    base06 = '#f3f2f2',
    base07 = '#f3f2f2',
    base08 = '#fd4663',
    base09 = '#8ac270',
    base0A = '#b6c76b',
    base0B = '#d7b775',
    base0C = '#b6d9a6',
    base0D = '#decaa1',
    base0E = '#d1dca3',
    base0F = '#b6b4af',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f3f2f2',          bg = '#23201a' })
  hi('TelescopeBorder',         { fg = '#6f6a5f',             bg = '#23201a' })
  hi('TelescopePromptNormal',   { fg = '#f3f2f2',          bg = '#23201a' })
  hi('TelescopePromptBorder',   { fg = '#6f6a5f',             bg = '#23201a' })
  hi('TelescopePromptPrefix',   { fg = '#d7b775',             bg = '#23201a' })
  hi('TelescopePromptCounter',  { fg = '#b6b4af',  bg = '#23201a' })
  hi('TelescopePromptTitle',    { fg = '#23201a',             bg = '#d7b775' })
  hi('TelescopePreviewTitle',   { fg = '#23201a',             bg = '#b6c76b' })
  hi('TelescopeResultsTitle',   { fg = '#23201a',             bg = '#8ac270' })
  hi('TelescopeSelection',      { fg = '#f3f2f2',          bg = '#363126' })
  hi('TelescopeSelectionCaret', { fg = '#d7b775',             bg = '#363126' })
  hi('TelescopeMatching',       { fg = '#d7b775',             bold = true })

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
