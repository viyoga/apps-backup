 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#0f0f0f',
    base01 = '#1e1e1e',
    base02 = '#282828',
    base03 = '#5f5f5f',
    base04 = '#bfaf9e',
    base05 = '#f4decd',
    base06 = '#f4decd',
    base07 = '#f4decd',
    base08 = '#f16e65',
    base09 = '#7ec9a3',
    base0A = '#7ec97e',
    base0B = '#ef934d',
    base0C = '#96e9bf',
    base0D = '#f4b88a',
    base0E = '#96e996',
    base0F = '#bfaf9e',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f4decd',          bg = '#0f0f0f' })
  hi('TelescopeBorder',         { fg = '#5f5f5f',             bg = '#0f0f0f' })
  hi('TelescopePromptNormal',   { fg = '#f4decd',          bg = '#0f0f0f' })
  hi('TelescopePromptBorder',   { fg = '#5f5f5f',             bg = '#0f0f0f' })
  hi('TelescopePromptPrefix',   { fg = '#ef934d',             bg = '#0f0f0f' })
  hi('TelescopePromptCounter',  { fg = '#bfaf9e',  bg = '#0f0f0f' })
  hi('TelescopePromptTitle',    { fg = '#0f0f0f',             bg = '#ef934d' })
  hi('TelescopePreviewTitle',   { fg = '#0f0f0f',             bg = '#7ec97e' })
  hi('TelescopeResultsTitle',   { fg = '#0f0f0f',             bg = '#7ec9a3' })
  hi('TelescopeSelection',      { fg = '#f4decd',          bg = '#282828' })
  hi('TelescopeSelectionCaret', { fg = '#ef934d',             bg = '#282828' })
  hi('TelescopeMatching',       { fg = '#ef934d',             bold = true })

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
