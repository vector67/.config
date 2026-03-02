vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

-- Close the import fold at the top of the file
vim.api.nvim_create_autocmd("BufWinEnter", {
	buffer = 0,
	once = true,
	callback = function()
		vim.defer_fn(function()
			local lines = vim.api.nvim_buf_get_lines(0, 0, math.min(100, vim.api.nvim_buf_line_count(0)), false)
			for i, line in ipairs(lines) do
				if line:match("^import ") or line:match("^from ") then
					-- Bail if treesitter folds aren't computed yet
					if vim.fn.foldlevel(i) == 0 then
						return
					end
					pcall(vim.cmd, i .. "foldclose")
					return
				end
			end
		end, 10)
	end,
})
