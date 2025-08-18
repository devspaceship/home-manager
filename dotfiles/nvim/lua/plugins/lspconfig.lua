return {
  "neovim/nvim-lspconfig",
  opts = function()
    vim.lsp.enable("sourcekit")
    vim.lsp.enable("biome")

    vim.lsp.enable("rubocop")
    vim.lsp.config("ruby_lsp", {
      cmd = { os.getenv("HOME") .. "/.rbenv/shims/ruby-lsp" },
    })
    vim.lsp.enable("ruby_lsp")
  end,
}
