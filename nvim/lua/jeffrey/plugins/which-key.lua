return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local wk = require('which-key')
    wk.add({
      { "<leader>f", group = "Find"},
      { "<leader>r", group = "Run"},
      { "<leader>b", group = "Buffers"},
      { "<leader>o", group = "Options"},
      { "<leader>i", group = "Insert"},
      { "<leader>w", group = "Wiki/Session"},

    })
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  end,
}
