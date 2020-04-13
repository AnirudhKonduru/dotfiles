" Plugin Settings here
let g:polyglot_disabled = ['c/c++', 'c++11']

call plug#begin('~/.vim/plugged')

" language packs
Plug 'sheerun/vim-polyglot'
Plug 'bfrg/vim-cpp-modern'

" colorschemes
Plug 'nanotech/jellybeans.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'erichdongubler/vim-sublime-monokai'

" misc
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

call plug#end()

" more settings
colorscheme jellybeans

