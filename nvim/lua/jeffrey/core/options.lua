vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.linebreak = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- search --
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.autowrite = true

opt.foldcolumn = "1" -- show foldcolumn
opt.foldenable = true -- enable fold for nvim-ufo
opt.foldlevel = 99 -- set high foldlevel for nvim-ufo
opt.foldlevelstart = 99 -- start with all code unfolded

opt.textwidth = 160
opt.formatoptions:append("t") -- By default auto wrap to "

-- vim.cmd("autocmd FocusLost * nested silent! wall")
local agrp = vim.api.nvim_create_augroup
local acmd = vim.api.nvim_create_autocmd

local _general = agrp("_general", { clear = true })
acmd({ "BufLeave", "FocusLost" }, {
	pattern = "*",
	command = ":wall",
	group = _general,
})

-- autosession config
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

acmd({ "BufEnter" }, {
	pattern = "NvimTree*",
	callback = function()
		local api = require("nvim-tree.api")
		local view = require("nvim-tree.view")

		if not view.is_visible() then
			api.tree.open()
		end
	end,
})

acmd({ "FileType" }, {
	callback = function(event)
		-- local ok, nvim_treesitter = pcall(require, "nvim-treesitter")
		--
		-- if not ok then
		-- 	vim.opt.foldmethod = "syntax"
		-- 	return
		-- end
		--
		-- local parsers = require("nvim-treesitter.parsers")
		--
		-- if not parsers[event.match] or not nvim_treesitter.install then
		-- 	vim.opt.foldmethod = "syntax"
		-- else
		-- 	vim.opt.foldmethod = "expr"
		-- 	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		-- end
	end,
})

-- au BufRead,BufWinEnter,BufNewFile *.{md,mdx,mdown,mkd,mkdn,markdown,mdwn} setlocal syntax=markdown

-- au BufRead,BufWinEnter,BufNewFile *.{md,mdx,mdown,mkd,mkdn,markdown,mdwn}.{des3,des,bf,bfa,aes,idea,cast,rc2,rc4,rc5,desx} setlocal syntax=markdown
