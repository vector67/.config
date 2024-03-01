set nocompatible
filetype plugin on
:syntax on
set termguicolors

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
:set relativenumber
:set autoindent

call plug#begin()
Plug 'vim-scripts/c.vim'
Plug 'github/copilot.vim'
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdcommenter'
Plug 'vim-autoformat/vim-autoformat'
Plug 'ctrlpvim/ctrlp.vim'
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

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set ttimeoutlen=100

"noremap <expr> gq 
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*/target/*
