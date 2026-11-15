local flake = string.format("(builtins.getFlake %s)", vim.json.encode(vim.fn.expand("~/.config/home-manager")))
local settings = {
  nixpkgs = {
    expr = "import " .. flake .. ".inputs.nixpkgs { }",
  },
  formatting = {
    command = { "nixfmt" },
  },
}

local target = vim.env.DEVSPACE
if target and target ~= "" then
  settings.options = {
    home_manager = {
      expr = flake .. ".homeConfigurations." .. vim.json.encode(target) .. ".options",
    },
  }
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      nixd = {
        mason = false,
        settings = { nixd = settings },
      },
      nil_ls = {
        mason = false,
        -- Supplement nixd with builtin completion and documentation.
        on_init = function(client)
          local capabilities = client.server_capabilities
          client.server_capabilities = {
            textDocumentSync = capabilities.textDocumentSync,
            positionEncoding = capabilities.positionEncoding,
            hoverProvider = capabilities.hoverProvider,
            completionProvider = capabilities.completionProvider,
          }
        end,
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
      },
    },
  },
}
