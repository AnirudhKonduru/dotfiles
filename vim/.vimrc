""" Adapted from https://dougblack.io/words/a-good-vimrc.html

" colors
syntax enable

" space and tabs
set tabstop=4
set softtabstop=4
set expandtab

" ui
set number relativenumber
set showcmd
set cursorline
filetype indent on

set wildmenu
set lazyredraw
set showmatch

" searching
set incsearch
set hlsearch
nnoremap <CR> :noh<CR><CR>

" folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax " or indent

" movement
nnoremap gV `[v`]
inoremap jk <esc>

" some custom bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>


