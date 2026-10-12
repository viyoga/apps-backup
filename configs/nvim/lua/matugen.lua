 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#2b282a',
    base01 = '#3d383a',
    base02 = '#484244',
    base03 = '#777074',
    base04 = '#b5a273',
    base05 = '#a39c96',
    base06 = '#a39c96',
    base07 = '#a39c96',
    base08 = '#9e6969',
    base09 = '#8c7584',
    base0A = '#82876d',
    base0B = '#b5a273',
    base0C = '#e996cc',
    base0D = '#e9d196',
    base0E = '#d9e996',
    base0F = '#b5a273',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#a39c96',          bg = '#2b282a' })
  hi('TelescopeBorder',         { fg = '#777074',             bg = '#2b282a' })
  hi('TelescopePromptNormal',   { fg = '#a39c96',          bg = '#2b282a' })
  hi('TelescopePromptBorder',   { fg = '#777074',             bg = '#2b282a' })
  hi('TelescopePromptPrefix',   { fg = '#b5a273',             bg = '#2b282a' })
  hi('TelescopePromptCounter',  { fg = '#b5a273',  bg = '#2b282a' })
  hi('TelescopePromptTitle',    { fg = '#2b282a',             bg = '#b5a273' })
  hi('TelescopePreviewTitle',   { fg = '#2b282a',             bg = '#82876d' })
  hi('TelescopeResultsTitle',   { fg = '#2b282a',             bg = '#8c7584' })
  hi('TelescopeSelection',      { fg = '#a39c96',          bg = '#484244' })
  hi('TelescopeSelectionCaret', { fg = '#b5a273',             bg = '#484244' })
  hi('TelescopeMatching',       { fg = '#b5a273',             bold = true })

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
