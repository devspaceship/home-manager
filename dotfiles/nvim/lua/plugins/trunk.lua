if vim.env.DEVSPACE == "work" then
  return {
    "trunk-io/neovim-trunk",
    lazy = false,
    config = {
      formatOnSave = false,
    },
    main = "trunk",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  }
else
  return {}
end
