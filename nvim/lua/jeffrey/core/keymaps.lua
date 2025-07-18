vim.g.mapleader = ","
vim.g.maplocalleader = ","

local keymap = vim.keymap

-- Toggle fold
keymap.set("n", " ", "za")

-- Find stuff
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
keymap.set(
	"n",
	"<leader>fe",
	"<cmd>lua vim.lsp.buf.references()<CR>",
	{ desc = "Find references", noremap = true, silent = true }
)
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
keymap.set(
	"n",
	"<leader>fo",
	"<cmd>lua vim.diagnostic.open_float()<CR>",
	{ noremap = true, silent = true, buffer = bufnr }
)
keymap.set("n", "gn<space>", "<Plug>VimwikiToggleListItem", { desc = "Toggle list item complete" })
keymap.set("n", "gl<space>", "<Plug>VimwikiToggleListItem", { desc = "Toggle list item complete" })
for x = 1, 5, 1 do
	for y = 1, 5, 1 do
		keymap.set("n", "glt" .. x .. y, ":VimwikiTable " .. x .. " " .. y .. "<cr>", { desc = "Vim wiki table" })
	end
end

-- Run stuff
keymap.set("n", "<leader>re", ":source ~/.vimrc<cr>", { desc = "Reload vimrc" })
keymap.set("n", "<leader>rmp", ":MarkdownPreview<cr>", { desc = "Run markdown preview" })
keymap.set("n", "<leader>rmt", ":MarkdownPreviewToggle<cr>", { desc = "Toggle markdown preview" })
keymap.set("n", "<leader>rms", ":MarkdownPreviewStop<cr>", { desc = "Stop markdown preview" })
keymap.set(
	"n",
	"<leader>rmo",
	':!pandoc -f markdown -o "<C-r>%<C-W>pdf" --lua-filter ~/.config/local/share/pandoc/filters/highlight.lua --resource-path=~/vimwiki --template=eisvogel "<C-r>%"<cr><cr>:!open "<C-r>%<C-W>pdf"<cr><cr>',
	{ desc = "Convert current file to pdf" }
)
keymap.set(
	"n",
	"<leader>rmd",
	':!pandoc -f markdown -o "<C-r>%<C-W>pdf" --lua-filter ~/.config/local/share/pandoc/filters/highlight.lua --resource-path=~/vimwiki --template=eisvogel "<C-r>%"',
	{ desc = "Convert current file to pdf (debug)" }
)

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>ss", ":wa<cr>", { desc = "Save entire file" })
keymap.set("n", "<leader>sp", ":setlocal spell spelllang=en_us<cr>", { desc = "Enable spell checking locally" })
keymap.set("n", "<leader>sP", ":setlocal nospell<cr>", { desc = "Disable spell checking locally" })
keymap.set("n", "<leader>st", ":set textwidth=160<cr>", { desc = "Enable textwidth wrapping" }) -- Side note, this shouldn't be necessary, but I can't figure out how to do this any other way

keymap.set("n", "<leader>ya", "ggvG$y", { desc = "Yank entire file" })

-- Buffers
keymap.set("n", "<leader>bn", ":bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", ":bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bd", ":bp<cr>:bdelete #<cr>", { desc = "Close the current buffer" })
keymap.set("n", "<leader>bl", ":buffers<cr>", { desc = "List the current buffers" })

-- Options
keymap.set("n", "<leader>oace", ":AutoCmpOn<cr>", { desc = "Enable auto complete for the current buffer" })
keymap.set("n", "<leader>oacd", ":AutoCmpOff<cr>", { desc = "Disable auto complete for the current buffer" })
keymap.set("n", "<leader>ost", ":set textwidth=160<cr>", { desc = "Set textwidth to 160" })
-- keymap.set("n", "<localleader>oo", "o<Esc>0\"_D", {desc = "New line below in normal mode"})
-- keymap.set("n", "<localleader>O", "O<Esc>0\"_D", {desc = "New line above in normal mode"})

keymap.set(
	"n",
	"s",
	':exec "normal i".nr2char(getchar())."\\e"<CR>',
	{ desc = "Insert one character then go back to normal mode" }
)
keymap.set(
	"n",
	"S",
	':exec "normal a".nr2char(getchar())."\\e"<CR>',
	{ desc = "Append one character then go back to normal mode" }
)
keymap.set("n", "<localleader>if", "i<C-r>=expand('%:t:r')<cr><Esc>", { desc = "Insert current file name" })
keymap.set("n", "<localleader>ii", "i# <C-r>=expand('%:t:r')<cr><cr><cr>", { desc = "Insert vimwiki header" })
keymap.set("n", "<localleader>il", ":VimwikiGenerateLinks ", { desc = "Generate links to files based on pattern" })

keymap.set("n", "<c-l>", "i<C-r>=strftime('%Y-%m-%d')<cr><Esc>", { desc = "Insert current date" })
keymap.set("i", "<c-l>", "<C-r>=strftime('%Y-%m-%d')<cr>", { desc = "Insert current date" })

-- iterm2 puts a strange character in when you hit shift escape and that's what this keymap is here for
keymap.set("t", "", "<C-\\><C-n><C-w>w")
keymap.set("t", "<S-Esc>", "<C-\\><C-n><C-w>w")
keymap.set("n", "", "<C-w>w")
keymap.set("n", "<S-Esc>", "<C-w>w")

-- Navigation
keymap.set("n", "<c-h>", "<c-w>h")
keymap.set("n", "<c-j>", "<c-w>j")
keymap.set("n", "<c-k>", "<c-w>k")
keymap.set("n", "<c-l>", "<c-w>l")
keymap.set("n", "<c-s>", ":wa<cr>")

keymap.set("n", "<leader>.n", "<cmd>cn<cr>", { desc = "Next jumplist item" })
keymap.set("n", "<leader>.p", "<cmd>cp<cr>", { desc = "Previous jumplist item" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("v", "<C-r>", "hy:%s/<C-r>h//gc<left><left><left>", { desc = "Replace" })

keymap.set("o", "iz", ":<c-u>normal! [zV]z<cr>")
