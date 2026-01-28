return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local keymap = vim.keymap

    -- Jump to next/prev function
    keymap.set({ "n", "x", "o" }, ";f", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer")
    end, { desc = "Next function" })
    keymap.set({ "n", "x", "o" }, ";F", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer")
    end, { desc = "Previous function" })

    -- Jump to next/prev class
    keymap.set({ "n", "x", "o" }, ";c", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer")
    end, { desc = "Next class" })
    keymap.set({ "n", "x", "o" }, ";C", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer")
    end, { desc = "Previous class" })

    -- Text objects: af/if = around/inside function, ac/ic = around/inside class
    keymap.set({ "x", "o" }, "af", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.outer")
    end, { desc = "Around function" })
    keymap.set({ "x", "o" }, "if", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.inner")
    end, { desc = "Inside function" })
    keymap.set({ "x", "o" }, "ac", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.outer")
    end, { desc = "Around class" })
    keymap.set({ "x", "o" }, "ic", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.inner")
    end, { desc = "Inside class" })
  end,
}
