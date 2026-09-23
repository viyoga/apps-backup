 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#101913',
    base01 = '#28302b',
    base02 = '#313b35',
    base03 = '#4c6b4c',
    base04 = '#798375',
    base05 = '#a1af9c',
    base06 = '#a1af9c',
    base07 = '#a1af9c',
    base08 = '#c87a5c',
    base09 = '#52987a',
    base0A = '#6aae52',
    base0B = '#4a9a68',
    base0C = '#96e9c5',
    base0D = '#96e9b5',
    base0E = '#abe996',
    base0F = '#798375',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#a1af9c',          bg = '#101913' })
  hi('TelescopeBorder',         { fg = '#4c6b4c',             bg = '#101913' })
  hi('TelescopePromptNormal',   { fg = '#a1af9c',          bg = '#101913' })
  hi('TelescopePromptBorder',   { fg = '#4c6b4c',             bg = '#101913' })
  hi('TelescopePromptPrefix',   { fg = '#4a9a68',             bg = '#101913' })
  hi('TelescopePromptCounter',  { fg = '#798375',  bg = '#101913' })
  hi('TelescopePromptTitle',    { fg = '#101913',             bg = '#4a9a68' })
  hi('TelescopePreviewTitle',   { fg = '#101913',             bg = '#6aae52' })
  hi('TelescopeResultsTitle',   { fg = '#101913',             bg = '#52987a' })
  hi('TelescopeSelection',      { fg = '#a1af9c',          bg = '#313b35' })
  hi('TelescopeSelectionCaret', { fg = '#4a9a68',             bg = '#313b35' })
  hi('TelescopeMatching',       { fg = '#4a9a68',             bold = true })

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
