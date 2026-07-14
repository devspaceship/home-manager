return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            procMacro = {
              ignored = { leptos_macro = { "server" } },
            },
            cargo = {
              features = "all",
            },
          },
        },
      },
    },
  },
}
