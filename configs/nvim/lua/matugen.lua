 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#161311',
    base01 = '#26211e',
    base02 = '#312b27',
    base03 = '#6b5f59',
    base04 = '#c4b4a1',
    base05 = '#e6dfd3',
    base06 = '#e6dfd3',
    base07 = '#e6dfd3',
    base08 = '#e37874',
    base09 = '#e09260',
    base0A = '#dfb26c',
    base0B = '#a2b574',
    base0C = '#eab694',
    base0D = '#d0e996',
    base0E = '#e9c896',
    base0F = '#c4b4a1',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e6dfd3',          bg = '#161311' })
  hi('TelescopeBorder',         { fg = '#6b5f59',             bg = '#161311' })
  hi('TelescopePromptNormal',   { fg = '#e6dfd3',          bg = '#161311' })
  hi('TelescopePromptBorder',   { fg = '#6b5f59',             bg = '#161311' })
  hi('TelescopePromptPrefix',   { fg = '#a2b574',             bg = '#161311' })
  hi('TelescopePromptCounter',  { fg = '#c4b4a1',  bg = '#161311' })
  hi('TelescopePromptTitle',    { fg = '#161311',             bg = '#a2b574' })
  hi('TelescopePreviewTitle',   { fg = '#161311',             bg = '#dfb26c' })
  hi('TelescopeResultsTitle',   { fg = '#161311',             bg = '#e09260' })
  hi('TelescopeSelection',      { fg = '#e6dfd3',          bg = '#312b27' })
  hi('TelescopeSelectionCaret', { fg = '#a2b574',             bg = '#312b27' })
  hi('TelescopeMatching',       { fg = '#a2b574',             bold = true })

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
