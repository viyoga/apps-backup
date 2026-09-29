 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#282828',
    base01 = '#32302f',
    base02 = '#3d3a39',
    base03 = '#75706c',
    base04 = '#a89984',
    base05 = '#ddc7a1',
    base06 = '#ddc7a1',
    base07 = '#ddc7a1',
    base08 = '#ea6962',
    base09 = '#7daea3',
    base0A = '#d8a657',
    base0B = '#a9b665',
    base0C = '#96e9d6',
    base0D = '#dbe996',
    base0E = '#e9c996',
    base0F = '#a89984',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#ddc7a1',          bg = '#282828' })
  hi('TelescopeBorder',         { fg = '#75706c',             bg = '#282828' })
  hi('TelescopePromptNormal',   { fg = '#ddc7a1',          bg = '#282828' })
  hi('TelescopePromptBorder',   { fg = '#75706c',             bg = '#282828' })
  hi('TelescopePromptPrefix',   { fg = '#a9b665',             bg = '#282828' })
  hi('TelescopePromptCounter',  { fg = '#a89984',  bg = '#282828' })
  hi('TelescopePromptTitle',    { fg = '#282828',             bg = '#a9b665' })
  hi('TelescopePreviewTitle',   { fg = '#282828',             bg = '#d8a657' })
  hi('TelescopeResultsTitle',   { fg = '#282828',             bg = '#7daea3' })
  hi('TelescopeSelection',      { fg = '#ddc7a1',          bg = '#3d3a39' })
  hi('TelescopeSelectionCaret', { fg = '#a9b665',             bg = '#3d3a39' })
  hi('TelescopeMatching',       { fg = '#a9b665',             bold = true })

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
