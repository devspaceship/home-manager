return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      always_show_bufferline = true,
    },
  },
  -- TEMP
  -- Until LazyVim follows the rename
  init = function()
    local bufferline = require("catppuccin.groups.integrations.bufferline")
    bufferline.get = bufferline.get_theme
  end,
  -- TEMP
}
