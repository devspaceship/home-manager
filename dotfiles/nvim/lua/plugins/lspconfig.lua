return {
  "neovim/nvim-lspconfig",
  opts = function()
    vim.lsp.enable("sourcekit")
    vim.lsp.enable("biome")
  end,
}
