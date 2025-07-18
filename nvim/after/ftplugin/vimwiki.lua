-- vim.api.nvim_feedkeys('za', 'n', false)

vim.api.nvim_create_autocmd("Syntax", {
	pattern = "vimwiki",
	callback = function()
		vim.api.nvim_set_hl(0, "VimwikiHighlight", { fg = "black", bg = "#ffff00", bold = true })
		vim.cmd([[
      syntax match VimwikiHighlight /==[^=]\+==/ containedin=ALL
    ]])
	end,
})
