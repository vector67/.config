return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
		},
	},
	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "mfussenegger/nvim-dap" },
		ft = "python",
		config = function()
			local path = vim.fn.getcwd() .. "/.venv/bin/python"
			if vim.fn.executable(path) ~= 1 then
				path = vim.fn.getcwd() .. "/venv/bin/python"
			end
			if vim.fn.executable(path) ~= 1 then
				path = vim.fn.exepath("python3") or "python"
			end
			require("dap-python").setup(path)
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			-- Auto open/close UI when debugging starts/ends
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
