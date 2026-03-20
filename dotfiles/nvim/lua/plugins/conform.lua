return {
  "stevearc/conform.nvim",
  opts = function()
    local biome_fts = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "jsonc",
      "graphql",
      "css",
      "astro",
      "svelte",
      "vue",
    }

    local formatters_by_ft = {
      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      kdl = { "kdlfmt" },
      rust = { "rustfmt" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      sh = function(_)
        if os.getenv("DEVSPACE") == "work" then
          return { "trunk" }
        else
          return { "shfmt" }
        end
      end,
      zsh = { "beautysh" },
      ["*"] = function(_)
        if os.getenv("DEVSPACE") == "work" then
          return { "trunk" }
        else
          return {}
        end
      end,
    }

    for _, ft in ipairs(biome_fts) do
      formatters_by_ft[ft] = { "biome", stop_after_first = true }
    end

    return {
      default_format_opts = {
        -- timeout_ms = 6000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      formatters_by_ft = formatters_by_ft,
    }
  end,
}
