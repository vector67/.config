return {
	"vimwiki/vimwiki",
	init = function()
		vim.g.vimwiki_list = { {
			syntax = "markdown",
			exts = "wiki",
			auto_tags = 1,
		} }
		vim.g.vimwiki_folding = "expr"
	end,
}
