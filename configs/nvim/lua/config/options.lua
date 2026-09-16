vim.opt.number = true
vim.opt.fileformats = "unix,dos" -- auto-detect CRLF (Windows) files
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "number"
vim.opt.numberwidth = 4
vim.opt.statuscolumn = "%l   %s"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.g.lazyvim_blur = false

-- Completely disable all diagnostics, linters, errors, and warnings globally
vim.diagnostic.enable(false)
vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = false,
})
