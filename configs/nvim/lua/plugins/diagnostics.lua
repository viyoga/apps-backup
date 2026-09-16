return {
  -- Completely disable background linters (like markdownlint)
  {
    "mfussenegger/nvim-lint",
    enabled = false,
  },

  -- Disable LSP diagnostics (inline errors, signs, underlines)
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = false,
        virtual_text = false,
        signs = false,
      },
    },
  },
}
