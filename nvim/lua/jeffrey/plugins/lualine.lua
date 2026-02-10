return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local theme = vim.o.background == "dark" and "solarized_dark" or "solarized_light"
    lualine.setup({
      options = {
        theme = theme,
      },
      sections = {
        lualine_b = {},
        lualine_c = {
          { "%f" }
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
