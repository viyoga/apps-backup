 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1c211e',
    base01 = '#2f3732',
    base02 = '#2a322d',
    base03 = '#5e6e63',
    base04 = '#afb6b1',
    base05 = '#f2f3f2',
    base06 = '#f2f3f2',
    base07 = '#f2f3f2',
    base08 = '#fd4663',
    base09 = '#9db4be',
    base0A = '#9ac1bb',
    base0B = '#95c6a4',
    base0C = '#afc6d0',
    base0D = '#acd2b8',
    base0E = '#afd0cb',
    base0F = '#afb6b1',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f3f2',          bg = '#1c211e' })
  hi('TelescopeBorder',         { fg = '#5e6e63',             bg = '#1c211e' })
  hi('TelescopePromptNormal',   { fg = '#f2f3f2',          bg = '#1c211e' })
  hi('TelescopePromptBorder',   { fg = '#5e6e63',             bg = '#1c211e' })
  hi('TelescopePromptPrefix',   { fg = '#95c6a4',             bg = '#1c211e' })
  hi('TelescopePromptCounter',  { fg = '#afb6b1',  bg = '#1c211e' })
  hi('TelescopePromptTitle',    { fg = '#1c211e',             bg = '#95c6a4' })
  hi('TelescopePreviewTitle',   { fg = '#1c211e',             bg = '#9ac1bb' })
  hi('TelescopeResultsTitle',   { fg = '#1c211e',             bg = '#9db4be' })
  hi('TelescopeSelection',      { fg = '#f2f3f2',          bg = '#2a322d' })
  hi('TelescopeSelectionCaret', { fg = '#95c6a4',             bg = '#2a322d' })
  hi('TelescopeMatching',       { fg = '#95c6a4',             bold = true })

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
