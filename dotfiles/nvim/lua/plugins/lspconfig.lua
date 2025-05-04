return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      -- Make
      autotools_ls = {},
      -- Python
      pyright = {},
      -- Swift
      sourcekit = {
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      },
    },
  },
}
