return {
  "neovim/nvim-lspconfig",
  opts = function()
    vim.lsp.enable("sourcekit")
  end,
}
