return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-go",
		"nvim-neotest/neotest-python",
	},
	config = function()
		local python = require("jeffrey.core.python")
		require("neotest").setup({
			output_panel = { open_on_run = true },
			adapters = {
				require("neotest-python")({
					runner = "pytest",
					python = python.get_python_path,
				}),
			},
		})
	end,
}
