 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1a2026',
    base01 = '#20272e',
    base02 = '#28313a',
    base03 = '#5e6b77',
    base04 = '#d9d1ba',
    base05 = '#d9d1ba',
    base06 = '#d9d1ba',
    base07 = '#d9d1ba',
    base08 = '#d96c6c',
    base09 = '#8ba37a',
    base0A = '#7794a6',
    base0B = '#d9a78b',
    base0C = '#b8e996',
    base0D = '#e9b496',
    base0E = '#96c9e9',
    base0F = '#d9d1ba',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#d9d1ba',          bg = '#1a2026' })
  hi('TelescopeBorder',         { fg = '#5e6b77',             bg = '#1a2026' })
  hi('TelescopePromptNormal',   { fg = '#d9d1ba',          bg = '#1a2026' })
  hi('TelescopePromptBorder',   { fg = '#5e6b77',             bg = '#1a2026' })
  hi('TelescopePromptPrefix',   { fg = '#d9a78b',             bg = '#1a2026' })
  hi('TelescopePromptCounter',  { fg = '#d9d1ba',  bg = '#1a2026' })
  hi('TelescopePromptTitle',    { fg = '#1a2026',             bg = '#d9a78b' })
  hi('TelescopePreviewTitle',   { fg = '#1a2026',             bg = '#7794a6' })
  hi('TelescopeResultsTitle',   { fg = '#1a2026',             bg = '#8ba37a' })
  hi('TelescopeSelection',      { fg = '#d9d1ba',          bg = '#28313a' })
  hi('TelescopeSelectionCaret', { fg = '#d9a78b',             bg = '#28313a' })
  hi('TelescopeMatching',       { fg = '#d9a78b',             bold = true })

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
