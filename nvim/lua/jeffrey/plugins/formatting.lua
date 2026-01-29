return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		-- Check if ruff.toml exists in project root
		local function has_ruff_config()
			local root = vim.fn.getcwd()
			return vim.fn.filereadable(root .. "/ruff.toml") == 1
				or vim.fn.filereadable(root .. "/pyproject.toml") == 1
		end

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "ruff_format" },
			},
			format_on_save = function(bufnr)
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				-- Only format Python files on save if ruff.toml exists
				if bufname:match("%.py$") then
					if has_ruff_config() then
						return { timeout_ms = 1000, lsp_fallback = false }
					end
					return false
				end
				return false
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
