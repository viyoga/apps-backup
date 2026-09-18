 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#13111a',
    base01 = '#1f1b29',
    base02 = '#282335',
    base03 = '#655d75',
    base04 = '#9c96aa',
    base05 = '#e2deea',
    base06 = '#e2deea',
    base07 = '#e2deea',
    base08 = '#e05a5a',
    base09 = '#629cb8',
    base0A = '#9b74b8',
    base0B = '#d85d7b',
    base0C = '#96cee9',
    base0D = '#e996aa',
    base0E = '#c596e9',
    base0F = '#9c96aa',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e2deea',          bg = '#13111a' })
  hi('TelescopeBorder',         { fg = '#655d75',             bg = '#13111a' })
  hi('TelescopePromptNormal',   { fg = '#e2deea',          bg = '#13111a' })
  hi('TelescopePromptBorder',   { fg = '#655d75',             bg = '#13111a' })
  hi('TelescopePromptPrefix',   { fg = '#d85d7b',             bg = '#13111a' })
  hi('TelescopePromptCounter',  { fg = '#9c96aa',  bg = '#13111a' })
  hi('TelescopePromptTitle',    { fg = '#13111a',             bg = '#d85d7b' })
  hi('TelescopePreviewTitle',   { fg = '#13111a',             bg = '#9b74b8' })
  hi('TelescopeResultsTitle',   { fg = '#13111a',             bg = '#629cb8' })
  hi('TelescopeSelection',      { fg = '#e2deea',          bg = '#282335' })
  hi('TelescopeSelectionCaret', { fg = '#d85d7b',             bg = '#282335' })
  hi('TelescopeMatching',       { fg = '#d85d7b',             bold = true })

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
