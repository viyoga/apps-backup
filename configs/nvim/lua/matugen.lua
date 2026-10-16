 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#181410',
    base01 = '#241e18',
    base02 = '#302820',
    base03 = '#715f4b',
    base04 = '#a68866',
    base05 = '#f5efe5',
    base06 = '#f5efe5',
    base07 = '#f5efe5',
    base08 = '#b87a59',
    base09 = '#8f7459',
    base0A = '#c2a37f',
    base0B = '#a68866',
    base0C = '#e9bf96',
    base0D = '#e9c296',
    base0E = '#e9c296',
    base0F = '#a68866',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f5efe5',          bg = '#181410' })
  hi('TelescopeBorder',         { fg = '#715f4b',             bg = '#181410' })
  hi('TelescopePromptNormal',   { fg = '#f5efe5',          bg = '#181410' })
  hi('TelescopePromptBorder',   { fg = '#715f4b',             bg = '#181410' })
  hi('TelescopePromptPrefix',   { fg = '#a68866',             bg = '#181410' })
  hi('TelescopePromptCounter',  { fg = '#a68866',  bg = '#181410' })
  hi('TelescopePromptTitle',    { fg = '#181410',             bg = '#a68866' })
  hi('TelescopePreviewTitle',   { fg = '#181410',             bg = '#c2a37f' })
  hi('TelescopeResultsTitle',   { fg = '#181410',             bg = '#8f7459' })
  hi('TelescopeSelection',      { fg = '#f5efe5',          bg = '#302820' })
  hi('TelescopeSelectionCaret', { fg = '#a68866',             bg = '#302820' })
  hi('TelescopeMatching',       { fg = '#a68866',             bold = true })

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
