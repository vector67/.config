"set nocompatible
"filetype plugin on
":syntax on

" set linebreak

" let g:molokai_original = 1
" let g:rehash256 = 1
" colorscheme molokai

set foldmethod=marker
set foldmarker={{{,}}}

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
lua require('config')


let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.wiki'}]


