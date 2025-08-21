return {
  "akinsho/bufferline.nvim",
  -- TEMP
  -- Until LazyVim follows the rename
  init = function()
    local bufferline = require("catppuccin.groups.integrations.bufferline")
    bufferline.get = bufferline.get_theme
  end,
  -- TEMP
}
