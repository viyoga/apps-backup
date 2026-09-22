 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#211f1c',
    base01 = '#37332f',
    base02 = '#322e2a',
    base03 = '#6c6964',
    base04 = '#b5b3b0',
    base05 = '#f3f2f2',
    base06 = '#f3f2f2',
    base07 = '#f3f2f2',
    base08 = '#fd4663',
    base09 = '#a2a38f',
    base0A = '#a5a08d',
    base0B = '#b3a798',
    base0C = '#c5c5b9',
    base0D = '#c9c0b6',
    base0E = '#c7c4b8',
    base0F = '#b5b3b0',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f3f2f2',          bg = '#211f1c' })
  hi('TelescopeBorder',         { fg = '#6c6964',             bg = '#211f1c' })
  hi('TelescopePromptNormal',   { fg = '#f3f2f2',          bg = '#211f1c' })
  hi('TelescopePromptBorder',   { fg = '#6c6964',             bg = '#211f1c' })
  hi('TelescopePromptPrefix',   { fg = '#b3a798',             bg = '#211f1c' })
  hi('TelescopePromptCounter',  { fg = '#b5b3b0',  bg = '#211f1c' })
  hi('TelescopePromptTitle',    { fg = '#211f1c',             bg = '#b3a798' })
  hi('TelescopePreviewTitle',   { fg = '#211f1c',             bg = '#a5a08d' })
  hi('TelescopeResultsTitle',   { fg = '#211f1c',             bg = '#a2a38f' })
  hi('TelescopeSelection',      { fg = '#f3f2f2',          bg = '#322e2a' })
  hi('TelescopeSelectionCaret', { fg = '#b3a798',             bg = '#322e2a' })
  hi('TelescopeMatching',       { fg = '#b3a798',             bold = true })

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
