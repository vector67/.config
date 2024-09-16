vim.g.mapleader = ","
vim.g.maplocalleader= ","

local keymap = vim.keymap

-- Find stuff
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>" )
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Run stuff
keymap.set("n", "<leader>re", ":source ~/.vimrc<cr>", {desc = "Reload vimrc"})
keymap.set("n", "<leader>rmp", ":MarkdownPreview<cr>", {desc = "Run markdown preview"})
keymap.set("n", "<leader>rmt", ":MarkdownPreviewToggle<cr>", {desc = "Toggle markdown preview"})
keymap.set("n", "<leader>rms", ":MarkdownPreviewStop<cr>", {desc = "Stop markdown preview"})
keymap.set("n", "<leader>rmo", ":!pandoc -f markdown -o \"<C-r>%<C-W>pdf\" --resource-path=/Users/etrnj73/vimwiki --template=eisvogel \"<C-r>%\"<cr><cr>:!open \"<C-r>%<C-W>pdf\"<cr><cr>", {desc = "Convert current file to pdf"})


keymap.set("n", "<leader>/", ":noh<cr>", {desc = "Clear current search"})
keymap.set("n", "<leader>ss", ":wa<cr>", {desc = "Save entire file"})
keymap.set("n", "<leader>sp", ":setlocal spell spelllang=en_us<cr>", {desc = "Enable spell checking locally"})
keymap.set("n", "<leader>ya", "ggvG$y", {desc = "Yank entire file"})
keymap.set("n", "<leader>bn", ":bnext<cr>", {desc = "Next buffer"})
keymap.set("n", "<leader>bp", ":bprevious<cr>", {desc = "Previous buffer"})
keymap.set("n", "<leader>bd", ":bdelete<cr>", {desc = "Close the current buffer"})

-- Options
keymap.set("n", "<leader>oace", ":AutoCmpOn<cr>", {desc = "Enable auto complete for the current buffer"})
keymap.set("n", "<leader>oacd", ":AutoCmpOff<cr>", {desc = "Disable auto complete for the current buffer"})
-- keymap.set("n", "<localleader>oo", "o<Esc>0\"_D", {desc = "New line below in normal mode"})
-- keymap.set("n", "<localleader>O", "O<Esc>0\"_D", {desc = "New line above in normal mode"})

keymap.set("n", "s", ":exec \"normal i\".nr2char(getchar()).\"\\e\"<CR>", {desc = "Insert one character then go back to normal mode"})
keymap.set("n", "S", ":exec \"normal a\".nr2char(getchar()).\"\\e\"<CR>", {desc = "Insert one character then go back to normal mode"})
keymap.set("n", "<localleader>if", "i<C-r>=expand('%:t:r')<cr><Esc>", {desc = "Insert current file name"})
keymap.set("n", "<localleader>id", "i<C-r>=strftime('%Y-%m-%d')<cr><Esc>", {desc = "Insert current date"})
keymap.set("i", "<c-l>", "<C-r>=strftime('%Y-%m-%d')<cr>", {desc = "Insert current date"})

keymap.set("t", "<S-Esc>", "<C-\\><C-n><C-w>w")
keymap.set("n", "<S-Esc>", "<C-w>w")
keymap.set("n", "<c-h>", "<c-w>h")
keymap.set("n", "<c-j>", "<c-w>j")
keymap.set("n", "<c-k>", "<c-w>k")
keymap.set("n", "<c-l>", "<c-w>l")
keymap.set("n", "<c-s>", ":wa<cr>")


keymap.set("v", "<C-r>", "hy:%s/<C-r>h//gc<left><left><left>", {desc = "Replace"})

