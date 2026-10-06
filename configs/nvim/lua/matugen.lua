 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1c221b',
    base01 = '#2f392d',
    base02 = '#2a3329',
    base03 = '#606e5e',
    base04 = '#b0b6af',
    base05 = '#f2f3f2',
    base06 = '#f2f3f2',
    base07 = '#f2f3f2',
    base08 = '#fd4663',
    base09 = '#85ada8',
    base0A = '#81b192',
    base0B = '#93c18b',
    base0C = '#afd0cc',
    base0D = '#b2d3ac',
    base0E = '#afd0ba',
    base0F = '#b0b6af',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f3f2',          bg = '#1c221b' })
  hi('TelescopeBorder',         { fg = '#606e5e',             bg = '#1c221b' })
  hi('TelescopePromptNormal',   { fg = '#f2f3f2',          bg = '#1c221b' })
  hi('TelescopePromptBorder',   { fg = '#606e5e',             bg = '#1c221b' })
  hi('TelescopePromptPrefix',   { fg = '#93c18b',             bg = '#1c221b' })
  hi('TelescopePromptCounter',  { fg = '#b0b6af',  bg = '#1c221b' })
  hi('TelescopePromptTitle',    { fg = '#1c221b',             bg = '#93c18b' })
  hi('TelescopePreviewTitle',   { fg = '#1c221b',             bg = '#81b192' })
  hi('TelescopeResultsTitle',   { fg = '#1c221b',             bg = '#85ada8' })
  hi('TelescopeSelection',      { fg = '#f2f3f2',          bg = '#2a3329' })
  hi('TelescopeSelectionCaret', { fg = '#93c18b',             bg = '#2a3329' })
  hi('TelescopeMatching',       { fg = '#93c18b',             bold = true })

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
