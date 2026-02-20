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
      { "<leader>.", group = "Jump lists" },
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code actions" },
      { "<leader>d", group = "Debug" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>i", group = "Insert" },
      { "<leader>m", group = "Maximize/Merge/Format" },
      { "<leader>n", group = "Clear search highlights" },
      { "<leader>o", group = "Options" },
      { "<leader>oa", group = "Autocomplete" },
      { "<leader>oc", group = "Colorscheme" },
      { "<leader>os", group = "Spell/Settings" },
      { "<leader>or", group = "Reset" },
      { "<leader>r", group = "Run" },
      { "<leader>rm", group = "Markdown" },
      { "<leader>s", group = "Splits/Save" },
      { "<leader>t", group = "Tabs" },
      { "<leader>w", group = "Wiki/Session" },
      { "<leader>y", group = "Yank" },
      { "<leader>yp", group = "Yank Python" },
    })
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  end,
}
