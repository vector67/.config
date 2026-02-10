vim.api.nvim_create_autocmd({ "Filetype" }, {
	callback = function(event)
		-- make sure nvim-treesitter is loaded
		local ok, nvim_treesitter = pcall(require, "nvim-treesitter")

		-- no nvim-treesitter, maybe fresh install
		if not ok then
			return
		end

		local parsers = require("nvim-treesitter.parsers")

		if not parsers[event.match] or not nvim_treesitter.install then
			return
		end

		local ft = vim.bo[event.buf].ft
		local lang = vim.treesitter.language.get_lang(ft)
		-- Only start if parser exists, fail silently otherwise
		if pcall(vim.treesitter.language.add, lang) then
			pcall(vim.treesitter.start, event.buf, lang)
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end
	end,
})

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	branch = "main",
	build = function()
		-- update parsers, if TSUpdate exists
		if vim.fn.exists(":TSUpdate") == 2 then
			vim.cmd("TSUpdate")
		end
	end,
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local ok, nvim_treesitter = pcall(require, "nvim-treesitter")

		-- no nvim-treesitter, maybe fresh install
		if not ok then
			return
		end

		local install_dir = vim.fn.stdpath("data") .. "/site"
		vim.notify("Installing parsers to: " .. install_dir)

		nvim_treesitter.setup({
			install_dir = install_dir,
		})

		local ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			-- "prisma",
			"markdown",
			"markdown_inline",
			-- "svelte",
			-- "graphql",
			"bash",
			"lua",
			-- "vim",
			"dockerfile",
			"gitignore",
			-- "query",
			-- "vimdoc",
			-- "c",
			"python",
		}
		nvim_treesitter.install(ensure_installed)
		-- treesitter.setup({ -- enable syntax highlighting
		-- 	highlight = {
		-- 		enable = true,
		-- 	},
		-- 	-- enable indentation
		-- 	indent = { enable = true },
		-- 	-- enable autotagging (w/ nvim-ts-autotag plugin)
		-- 	autotag = {
		-- 		enable = true,
		-- 	},
		-- 	-- ensure these language parsers are installed
		-- 	incremental_selection = {
		-- 		enable = true,
		-- 		keymaps = {
		-- 			init_selection = "<C-space>",
		-- 			node_incremental = "<C-space>",
		-- 			scope_incremental = false,
		-- 			node_decremental = "<bs>",
		-- 		},
		-- 	},
		-- })
	end,
}
