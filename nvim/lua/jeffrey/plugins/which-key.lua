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
      { "<leader>.", group = "Jump lists"},
      { "<leader>b", group = "Buffers"},
      { "<leader>e", group = "file Explorer"},
      { "<leader>i", group = "Insert"},
      { "<leader>f", group = "Find"},
      { "<leader>m", group = "Maximize/Minimize/Format"},
      { "<leader>n", group = "Clear search highlights"},
      { "<leader>o", group = "Options"},
      { "<leader>r", group = "Run"},
      { "<leader>s", group = "Splits/spellcheck/save"},
      { "<leader>t", group = "Tabs"},
      { "<leader>w", group = "Wiki/Session"},
      { "<leader>y", group = "Yank"},

    })
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  end,
}
