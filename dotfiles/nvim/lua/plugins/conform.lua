return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      rust = { "rustfmt" },
      sh = function(_)
        if os.getenv("DEVSPACE") == "work" then
          return { "trunk" }
        else
          return { "shfmt" }
        end
      end,
    },
    formatters = {
      trunk = {
        command = "trunk",
        args = { "fmt", "$FILENAME" },
        stdin = false,
      },
    },
  },
}
