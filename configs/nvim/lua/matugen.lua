 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#091518',
    base01 = '#162124',
    base02 = '#202c2f',
    base03 = '#7c959b',
    base04 = '#b2cbd2',
    base05 = '#d8e5e8',
    base06 = '#d8e5e8',
    base07 = '#d8e5e8',
    base08 = '#ffb4ab',
    base09 = '#83d2e5',
    base0A = '#8ed5b0',
    base0B = '#6fdba8',
    base0C = '#83d2e5',
    base0D = '#6fdba8',
    base0E = '#8ed5b0',
    base0F = '#b2cbd2',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#d8e5e8',          bg = '#091518' })
  hi('TelescopeBorder',         { fg = '#7c959b',             bg = '#091518' })
  hi('TelescopePromptNormal',   { fg = '#d8e5e8',          bg = '#091518' })
  hi('TelescopePromptBorder',   { fg = '#7c959b',             bg = '#091518' })
  hi('TelescopePromptPrefix',   { fg = '#6fdba8',             bg = '#091518' })
  hi('TelescopePromptCounter',  { fg = '#b2cbd2',  bg = '#091518' })
  hi('TelescopePromptTitle',    { fg = '#091518',             bg = '#6fdba8' })
  hi('TelescopePreviewTitle',   { fg = '#091518',             bg = '#8ed5b0' })
  hi('TelescopeResultsTitle',   { fg = '#091518',             bg = '#83d2e5' })
  hi('TelescopeSelection',      { fg = '#d8e5e8',          bg = '#202c2f' })
  hi('TelescopeSelectionCaret', { fg = '#6fdba8',             bg = '#202c2f' })
  hi('TelescopeMatching',       { fg = '#6fdba8',             bold = true })

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
