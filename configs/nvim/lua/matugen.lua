 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#12140e',
    base01 = '#1e2019',
    base02 = '#282b24',
    base03 = '#8e9382',
    base04 = '#c4c9b6',
    base05 = '#e2e3d8',
    base06 = '#e2e3d8',
    base07 = '#e2e3d8',
    base08 = '#ffb4ab',
    base09 = '#6cdbad',
    base0A = '#bbcd9e',
    base0B = '#abd371',
    base0C = '#6cdbad',
    base0D = '#abd371',
    base0E = '#bbcd9e',
    base0F = '#c4c9b6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e2e3d8',          bg = '#12140e' })
  hi('TelescopeBorder',         { fg = '#8e9382',             bg = '#12140e' })
  hi('TelescopePromptNormal',   { fg = '#e2e3d8',          bg = '#12140e' })
  hi('TelescopePromptBorder',   { fg = '#8e9382',             bg = '#12140e' })
  hi('TelescopePromptPrefix',   { fg = '#abd371',             bg = '#12140e' })
  hi('TelescopePromptCounter',  { fg = '#c4c9b6',  bg = '#12140e' })
  hi('TelescopePromptTitle',    { fg = '#12140e',             bg = '#abd371' })
  hi('TelescopePreviewTitle',   { fg = '#12140e',             bg = '#bbcd9e' })
  hi('TelescopeResultsTitle',   { fg = '#12140e',             bg = '#6cdbad' })
  hi('TelescopeSelection',      { fg = '#e2e3d8',          bg = '#282b24' })
  hi('TelescopeSelectionCaret', { fg = '#abd371',             bg = '#282b24' })
  hi('TelescopeMatching',       { fg = '#abd371',             bold = true })

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
