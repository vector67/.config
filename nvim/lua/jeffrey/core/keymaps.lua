vim.g.mapleader = ","
vim.g.maplocalleader = ","

local keymap = vim.keymap

-- Toggle fold
keymap.set("n", " ", "za")

-- Find stuff
local function get_nvim_tree_dir()
	if vim.bo.filetype ~= "NvimTree" then
		return nil
	end
	local ok, api = pcall(require, "nvim-tree.api")
	if not ok then
		return nil
	end
	local node = api.tree.get_node_under_cursor()
	if not node then
		return nil
	end
	if node.type == "directory" then
		return node.absolute_path
	else
		return vim.fn.fnamemodify(node.absolute_path, ":h")
	end
end

keymap.set("n", "<leader>ff", function()
	local dir = get_nvim_tree_dir()
	require("telescope.builtin").find_files({ cwd = dir })
end, { desc = "Find files" })
keymap.set("n", "<leader>fg", function()
	local dir = get_nvim_tree_dir()
	require("telescope.builtin").live_grep({ cwd = dir })
end, { desc = "Live grep" })
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
keymap.set("n", "<leader>rt", function()
	if vim.bo.filetype == "python" then
		local neotest = require("neotest")
		neotest.run.run(vim.fn.getcwd() .. "/tests")
		neotest.summary.open()
	else
		vim.cmd("make test")
	end
end, { desc = "Run tests" })
keymap.set("n", "<leader>rn", function() require("neotest").run.run() end, { desc = "Run nearest test" })
keymap.set("n", "<leader>rd", function() require("neotest").run.run({strategy = "dap"}) end, { desc = "Debug nearest test" })
keymap.set("n", "<leader>rf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run file tests" })
keymap.set("n", "<leader>ro", function()
	require("neotest").output_panel.toggle()
end, { desc = "Toggle test output panel" })
keymap.set("n", "<leader>rO", function()
	require("neotest").output.open({ enter = false })
end, { desc = "Show test output popup" })

keymap.set("n", "<leader>yi", function()
	local path = vim.fn.expand("%:p") -- full path
	local cwd = vim.fn.getcwd()
	local rel = path:gsub("^" .. vim.pesc(cwd) .. "/", "") -- relative to cwd
	local import = rel:gsub("%.py$", ""):gsub("/", ".") -- convert to import
	vim.fn.setreg("+", "from " .. import .. " import ")
	print("Copied: from " .. import .. " import ")
end, { desc = "Copy file path as Python import" })
keymap.set("n", "<leader>ypt", function()
	if vim.bo.filetype ~= "python" then
		print("This only works for Python files")
		return
	end
	local file = vim.fn.expand("%:.")
	local test_name = nil
	local class_name = nil
	local node = vim.treesitter.get_node()
	while node do
		local type = node:type()
		if type == "function_definition" and not test_name then
			local name_node = node:field("name")[1]
			if name_node then
				test_name = vim.treesitter.get_node_text(name_node, 0)
			end
		elseif type == "class_definition" then
			local name_node = node:field("name")[1]
			if name_node then
				class_name = vim.treesitter.get_node_text(name_node, 0)
			end
		end
		node = node:parent()
	end
	local cmd = "pytest " .. file
	if class_name and test_name then
		cmd = cmd .. "::" .. class_name .. "::" .. test_name
	elseif test_name then
		cmd = cmd .. "::" .. test_name
	end
	cmd = cmd .. " -vvs --tb=long"
	vim.fn.setreg("+", cmd)
	print("Copied: " .. cmd)
end, { desc = "Yank pytest command for current test" })

-- Debug
keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue/Start debugging" })
keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step into" })
keymap.set("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step over" })
keymap.set("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step out" })
keymap.set("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate debugging" })
keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle debug UI" })

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

-- This is a bit of a weird one because why can't you just set textwidth in the config. The problem is that certain plugins overwrite this configuration on
-- buffer open for certain file types and I haven't bothered to chase all of them down and tell them not to.
keymap.set(
	"n",
	"<leader>st",
	":set textwidth=160<cr>gqap",
	{ desc = "Enable textwidth wrapping and wrap current paragraph" }
)

keymap.set("n", "<leader>ya", ":%y<cr>", { desc = "Yank entire file" })

-- Buffers
keymap.set("n", "<leader>bn", ":bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", ":bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bd", ":bp<cr>:bdelete #<cr>", { desc = "Close the current buffer" })
keymap.set("n", "<leader>bD", ":%bd|e#|bd#<cr>", { desc = "Close all other buffers" })
keymap.set("n", "<leader>bl", ":buffers<cr>", { desc = "List the current buffers" })
keymap.set("n", "<leader>bs", "<cmd>Telescope buffers<cr>", { desc = "Search current buffers" })

-- Options
keymap.set("n", "<leader>ocs", "<cmd>Telescope colorscheme enable_preview=true<cr>", { desc = "Select colorscheme" })
keymap.set("n", "<leader>oace", ":AutoCmpOn<cr>", { desc = "Enable auto complete for the current buffer" })
keymap.set("n", "<leader>oacd", ":AutoCmpOff<cr>", { desc = "Disable auto complete for the current buffer" })
keymap.set("n", "<leader>ost", ":set textwidth=160<cr>", { desc = "Set textwidth to 160" })
keymap.set("n", "<leader>osp", ":setlocal spell spelllang=en_us<cr>", { desc = "Enable spell checking locally" })
keymap.set("n", "<leader>osP", ":setlocal nospell<cr>", { desc = "Disable spell checking locally" })
keymap.set("n", "<leader>orw", function()
	vim.cmd("windo set nowinfixwidth nowinfixheight")
	vim.cmd("wincmd =")
end, { desc = "Reset windows and equalize" })
-- keymap.set("n", "<localleader>oo", "o<Esc>0\"_D", {desc = "New line below in normal mode"})
-- keymap.set("n", "<localleader>O", "O<Esc>0\"_D", {desc = "New line above in normal mode"})

-- s is now used as prefix for treesitter navigation (sa/so/se/su)
-- S remains available - restore substitute line behavior
keymap.set("n", "S", "cc", { desc = "Substitute line" })
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

keymap.set("n", "<C-`>", function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_set_current_buf(buf)
			return
		end
	end
	print("No terminal buffer found")
end, { desc = "Switch to terminal buffer" })

-- Navigation
keymap.set("n", "<c-h>", "<c-w>h")
keymap.set("n", "<c-j>", "<c-w>j")
keymap.set("n", "<c-k>", "<c-w>k")
keymap.set("n", "<c-l>", "<c-w>l")
keymap.set("n", "<c-s>", ":wa<cr>")

keymap.set("n", "<leader>.n", "<cmd>cn<cr>", { desc = "Next jumplist item" })
keymap.set("n", "<leader>.p", "<cmd>cp<cr>", { desc = "Previous jumplist item" })
keymap.set("n", "<leader>.t", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })
keymap.set("n", "<leader>.h", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Previous error" })
keymap.set("n", "<leader>.m", function()
	local node = vim.treesitter.get_node()
	while node do
		local type = node:type()
		if type:match("function") or type:match("method") then
			local row = node:start()
			vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
			vim.cmd("normal! zt")
			return
		end
		node = node:parent()
	end
end, { desc = "Jump to enclosing method" })
keymap.set("n", "<leader>.c", function()
	local node = vim.treesitter.get_node()
	while node do
		local type = node:type()
		if type:match("class") then
			local row = node:start()
			vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
			vim.cmd("normal! zt")
			return
		end
		node = node:parent()
	end
end, { desc = "Jump to enclosing class" })
keymap.set("n", "<leader>.o", "vibgx", { desc = "Open next file in brackets with the system default" })

-- window management
keymap.set("n", "<leader>ssv", ":VimwikiVSplitLink<cr>", { desc = "Split window vertically and open vimwiki link" }) -- split window vertically
keymap.set("n", "<leader>sV", "<C-w>v:term<cr>", { desc = "Split window vertically and open terminal" }) -- split window vertically
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<leader>sc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("v", "<C-r>", "hy:%s/<C-r>h//gc<left><left><left>", { desc = "Replace" })

keymap.set("o", "iz", ":<c-u>normal! [zV]z<cr>")
