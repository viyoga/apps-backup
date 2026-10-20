 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1a1b1c',
    base01 = '#252627',
    base02 = '#2f3031',
    base03 = '#656668',
    base04 = '#a69d96',
    base05 = '#cdc5bd',
    base06 = '#cdc5bd',
    base07 = '#cdc5bd',
    base08 = '#db6d6d',
    base09 = '#8faeb1',
    base0A = '#d1b394',
    base0B = '#db6d6d',
    base0C = '#96e1e9',
    base0D = '#e99696',
    base0E = '#e9c096',
    base0F = '#a69d96',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#cdc5bd',          bg = '#1a1b1c' })
  hi('TelescopeBorder',         { fg = '#656668',             bg = '#1a1b1c' })
  hi('TelescopePromptNormal',   { fg = '#cdc5bd',          bg = '#1a1b1c' })
  hi('TelescopePromptBorder',   { fg = '#656668',             bg = '#1a1b1c' })
  hi('TelescopePromptPrefix',   { fg = '#db6d6d',             bg = '#1a1b1c' })
  hi('TelescopePromptCounter',  { fg = '#a69d96',  bg = '#1a1b1c' })
  hi('TelescopePromptTitle',    { fg = '#1a1b1c',             bg = '#db6d6d' })
  hi('TelescopePreviewTitle',   { fg = '#1a1b1c',             bg = '#d1b394' })
  hi('TelescopeResultsTitle',   { fg = '#1a1b1c',             bg = '#8faeb1' })
  hi('TelescopeSelection',      { fg = '#cdc5bd',          bg = '#2f3031' })
  hi('TelescopeSelectionCaret', { fg = '#db6d6d',             bg = '#2f3031' })
  hi('TelescopeMatching',       { fg = '#db6d6d',             bold = true })

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
