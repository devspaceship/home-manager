-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Override LazyVim's default keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  once = true,
  callback = function()
    pcall(vim.keymap.del, "n", "<leader>ua") -- toggle animations
    pcall(vim.keymap.del, "n", "<leader>uA") -- toggle tabline
    pcall(vim.keymap.del, "n", "<leader>ub") -- toggle dark background
    pcall(vim.keymap.del, "n", "<leader>uc") -- toggle conceal level
    pcall(vim.keymap.del, "n", "<leader>uC") -- change colorscheme
    pcall(vim.keymap.del, "n", "<leader>ug") -- toggle indent
    pcall(vim.keymap.del, "n", "<leader>ui") -- inspect ast node
    pcall(vim.keymap.del, "n", "<leader>uI") -- inspect ast tree
    pcall(vim.keymap.del, "n", "<leader>ul") -- toggle line numbers
    pcall(vim.keymap.del, "n", "<leader>uL") -- toggle relative line numbers
    pcall(vim.keymap.del, "n", "<leader>uS") -- toggle smooth scrolling
    pcall(vim.keymap.del, "n", "<leader>us") -- toggle spelling
    pcall(vim.keymap.del, "n", "<leader>ut") -- toggle treesitter context
    pcall(vim.keymap.del, "n", "<leader>uT") -- toggle treesitter highlight
    pcall(vim.keymap.del, "n", "<leader>uZ") -- toggle zoom
  end,
})

-- <leader>uG is registered by LazyVim's gitsigns spec at plugin load time (LazyFile event).
-- If gitsigns is already loaded (e.g. when nvim is opened with a file argument), delete
-- the keymap immediately; otherwise wait for it to load.
local function del_uG()
  pcall(vim.keymap.del, "n", "<leader>uG") -- toggle git signs
end

if package.loaded["gitsigns"] then
  del_uG()
else
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(event)
      if event.data == "gitsigns.nvim" then
        vim.schedule(del_uG)
        return true -- unregister autocmd
      end
    end,
  })
end
