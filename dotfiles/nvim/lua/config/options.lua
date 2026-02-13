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
-- vim.g.vimtex_compiler_latexmk.aux_dir = "./.aux"
vim.g.vimtex_compiler_latexmk = {
  aux_dir = "./.aux",
}
-- let g:vimtex_compiler_latexmk = {
--         \ 'aux_dir' : '',
--         \ 'out_dir' : '',
--         \ 'callback' : 1,
--         \ 'continuous' : 1,
--         \ 'executable' : 'latexmk',
--         \ 'hooks' : [],
--         \ 'options' : [
--         \   '-verbose',
--         \   '-file-line-error',
--         \   '-synctex=1',
--         \   '-interaction=nonstopmode',
--         \ ],
--         \}
