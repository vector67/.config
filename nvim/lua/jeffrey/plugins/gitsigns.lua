return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      current_line_blame = false,
      current_line_blame_opts = {
        delay = 300,
      },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
    keymap.set("n", "<leader>gB", "<cmd>Gitsigns blame<cr>", { desc = "Blame file" })
    keymap.set("n", "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle line blame" })
    keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
    keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
    keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
    keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" })

    -- Merge conflict resolution (use in mergetool's diff view)
    keymap.set("n", "<leader>ml", "<cmd>diffget LOCAL<cr>", { desc = "Get from LOCAL (ours)" })
    keymap.set("n", "<leader>mr", "<cmd>diffget REMOTE<cr>", { desc = "Get from REMOTE (theirs)" })
    keymap.set("n", "<leader>mb", "<cmd>diffget BASE<cr>", { desc = "Get from BASE" })
    keymap.set("n", "<leader>mL", "<cmd>%diffget LOCAL<cr>", { desc = "Take all from LOCAL (ours)" })
    keymap.set("n", "<leader>mR", "<cmd>%diffget REMOTE<cr>", { desc = "Take all from REMOTE (theirs)" })

    -- When opening as mergetool, move cursor to MERGED (middle) pane and jump to first conflict
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("MergetoolCursor", { clear = true }),
      callback = function()
        if vim.wo.diff and vim.fn.winnr("$") == 3 then
          vim.cmd("2wincmd w")
          vim.fn.search("^<<<<<<<", "cw")
        end
      end,
    })
  end,
}
