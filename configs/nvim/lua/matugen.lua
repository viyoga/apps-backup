 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#15130f',
    base01 = '#1f1a13',
    base02 = '#2c251b',
    base03 = '#7a6849',
    base04 = '#c9b99a',
    base05 = '#f3e9d8',
    base06 = '#f3e9d8',
    base07 = '#f3e9d8',
    base08 = '#e2604a',
    base09 = '#7fa0b8',
    base0A = '#b54a32',
    base0B = '#e8a33d',
    base0C = '#96c6e9',
    base0D = '#f1c98d',
    base0E = '#e9a596',
    base0F = '#c9b99a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f3e9d8',          bg = '#15130f' })
  hi('TelescopeBorder',         { fg = '#7a6849',             bg = '#15130f' })
  hi('TelescopePromptNormal',   { fg = '#f3e9d8',          bg = '#15130f' })
  hi('TelescopePromptBorder',   { fg = '#7a6849',             bg = '#15130f' })
  hi('TelescopePromptPrefix',   { fg = '#e8a33d',             bg = '#15130f' })
  hi('TelescopePromptCounter',  { fg = '#c9b99a',  bg = '#15130f' })
  hi('TelescopePromptTitle',    { fg = '#15130f',             bg = '#e8a33d' })
  hi('TelescopePreviewTitle',   { fg = '#15130f',             bg = '#b54a32' })
  hi('TelescopeResultsTitle',   { fg = '#15130f',             bg = '#7fa0b8' })
  hi('TelescopeSelection',      { fg = '#f3e9d8',          bg = '#2c251b' })
  hi('TelescopeSelectionCaret', { fg = '#e8a33d',             bg = '#2c251b' })
  hi('TelescopeMatching',       { fg = '#e8a33d',             bold = true })

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
