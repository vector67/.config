return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = {
							"vim",
							"require",
						},
					},
				},
			},
		})

		local python = require("jeffrey.core.python")
		local get_python_path = python.get_python_path

		-- Register the Pyright server using the new vim.lsp.configs API
		vim.lsp.config["pyright"] = {
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_markers = {
				"pyrightconfig.json",
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				"Pipfile",
				".git",
			},
			settings = {
				python = {
					pythonPath = get_python_path(),
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						typeCheckingMode = "basic",
						autoImportCompletions = true,
					},
				},
				pyright = {
					disableOrganizeImports = true, -- let ruff handle this
				},
			},
		}

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local function goto_def_in_split(direction, split_cmd)
			local params = vim.lsp.util.make_position_params()
			local results = vim.lsp.buf_request_sync(0, "textDocument/definition", params, 1000)
			if not results then
				return
			end

			local result
			for _, res in pairs(results) do
				if res.result and not vim.tbl_isempty(res.result) then
					result = vim.tbl_islist(res.result) and res.result[1] or res.result
					break
				end
			end
			if not result then
				return
			end

			if vim.fn.winnr(direction) ~= vim.fn.winnr() then
				vim.cmd("wincmd " .. direction)
			else
				vim.cmd(split_cmd)
			end

			vim.lsp.util.jump_to_location(result, "utf-8")
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to definition"
				keymap.set("n", "gD", vim.lsp.buf.definition, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Go to definition"
				keymap.set("n", "<leader>gc", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Go to definition in vertical split"
				keymap.set("n", "<leader>gr", function() goto_def_in_split("l", "vsplit") end, opts)

				opts.desc = "Go to definition in horizontal split"
				keymap.set("n", "<leader>gl", function() goto_def_in_split("j", "split") end, opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rN", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>h", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if not client then
					return
				end

				-- adjust this name if you use a different python language server
				if client.name == "pyright" or client.name == "pylsp" or client.name == "python-ls" then
					local bufnr = ev.buf
					python.setup_pytest_for_buf(bufnr)
				end
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local D = vim.diagnostic.severity

		local diagnostics = {
			[D.ERROR] = { icon = " ", texthl = "DiagnosticSignError" },
			[D.WARN] = { icon = " ", texthl = "DiagnosticSignWarn" },
			[D.HINT] = { icon = "󰠠 ", texthl = "DiagnosticSignHint" },
			[D.INFO] = { icon = " ", texthl = "DiagnosticSignInfo" },
		}

		local text, texthl, numhl = {}, {}, {}

		for sev, cfg in pairs(diagnostics) do
			text[sev] = cfg.icon
			texthl[sev] = cfg.texthl
			numhl[sev] = nil
		end

		vim.diagnostic.config({
			signs = {
				text = text,
				texthl = texthl,
				numhl = numhl,
			},
		})
		-- vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end,
}
