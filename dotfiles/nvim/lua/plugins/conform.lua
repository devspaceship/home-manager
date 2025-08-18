return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt" },
      sh = { "shfmt" },
    },
  },
}
