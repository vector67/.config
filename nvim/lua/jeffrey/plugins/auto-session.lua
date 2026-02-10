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
      restore_error_handler = function(error_msg)
        -- Move the broken session file aside for analysis
        local session_dir = vim.fn.stdpath("data") .. "/sessions/"
        local broken_dir = session_dir .. "broken/"
        vim.fn.mkdir(broken_dir, "p")

        -- Session files are named by percent-encoding the cwd
        local cwd = vim.fn.getcwd()
        local session_name = cwd:gsub("/", "%%2F")
        local session_file = session_dir .. session_name .. ".vim"

        if vim.fn.filereadable(session_file) == 1 then
          local timestamp = os.date("%Y%m%d_%H%M%S")
          local broken_file = broken_dir .. session_name .. "_" .. timestamp .. ".vim"
          vim.fn.rename(session_file, broken_file)
          vim.notify("Broken session moved to: " .. broken_file, vim.log.levels.WARN)
        end

        vim.notify("Session restore failed, starting fresh.\nError: " .. error_msg, vim.log.levels.WARN)
        -- Return true to keep auto_save enabled so a new session gets written
        return true
      end,
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wo", "<cmd>SessionRestore<CR>", { desc = "Open saved session for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
    keymap.set("n", "<leader>we", "<cmd>SessionSearch<CR>", { desc = "Search for session" }) 
  end,
}
