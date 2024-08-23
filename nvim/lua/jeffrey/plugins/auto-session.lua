return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      -- auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
      auto_save_enabled = true,
      auto_restore_enabled = true,
      args_allow_files_auto_save = true,
      -- log_level = 'debug'
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wo", "<cmd>SessionRestore<CR>", { desc = "Open saved session for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
    keymap.set("n", "<leader>we", "<cmd>SessionSearch<CR>", { desc = "Search for session" }) 
  end,
}
