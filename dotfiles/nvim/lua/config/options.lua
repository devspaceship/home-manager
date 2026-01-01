-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.completeopt:append("popup")

-- LSP
vim.lsp.config("sourcekit", {})
vim.lsp.enable("sourcekit")
vim.lsp.config("biome", {})
vim.lsp.enable("biome")
vim.lsp.config("racket-langserver", {})
vim.lsp.enable("racket_langserver")

-- VimTex
vim.g.vimtex_view_method = "zathura"
