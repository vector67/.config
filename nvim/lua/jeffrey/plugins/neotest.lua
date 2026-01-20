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
		require("neotest").setup({
			output_panel = { open_on_run = true },
			adapters = {
				require("neotest-python")({
					runner = "pytest",
				}),
			},
		})
	end,
}
