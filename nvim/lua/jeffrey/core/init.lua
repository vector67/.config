-- Compatibility shim for older plugins
if not vim.treesitter.language.ft_to_lang then
	vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
end
require("jeffrey.core.options")
require("jeffrey.core.keymaps")
require("jeffrey.core.nvim-cmp")
-- require("jeffrey.core.lspinfo")
-- require("jeffrey.core.lsp_jedi")
-- require'lspconfig'.pyright.setup{}
