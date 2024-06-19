set nocompatible
filetype plugin on
:syntax on
set termguicolors
set ts=4 sts=4 sw=4 expandtab

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
:set relativenumber
:set autoindent
set linebreak

call plug#begin()
Plug 'vim-scripts/c.vim'
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdcommenter'
Plug 'vim-autoformat/vim-autoformat'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
call plug#end()
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

let maplocalleader=','
let mapleader=','
nnoremap <localleader>o o<Esc>0"_D
nnoremap <localleader>O O<Esc>0"_D
set clipboard=unnamed
set foldmethod=marker
set foldmarker={{{,}}}

set ignorecase
set incsearch
set hlsearch

nnoremap ª <C-a>
nnoremap º <C-x>

autocmd FileType python map <buffer> <F9> :w<CR>:ter python3 %<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:ter python3 %<CR>
autocmd FocusLost * nested silent! wall

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set ttimeoutlen=100

"noremap <expr> gq 
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*/target/*
lua require('config')

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>re :source ~/.vimrc<cr>
nnoremap <leader>/ :noh<cr>
nnoremap <leader>s :wa<cr>
nnoremap <leader>ya ggvG$y
nnoremap <c-s> :wa<cr>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.wiki'}]

tnoremap <S-Esc> <C-\><C-n><C-w>w
nnoremap <S-Esc> <C-w>w
