vim.cmd("set runtimepath^=~/.vim runtimepath+=~/.vim/after")
vim.cmd("let &packpath = &runtimepath")
--vim.cmd("source ~/.vimrc")
require("jeffrey.core")
require("jeffrey.lazy")
require'lspconfig'.pyright.setup{}
