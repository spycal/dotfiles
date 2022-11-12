
" settigns
set number
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible
filetype plugin on

call plug#begin('~/.vim/plugged')

Plug 'Everblush/everblush.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }

call plug#end()

" colorscheme
set termguicolors
colo everblush

" statusline
set laststatus=2
set statusline=%1*\ %f\ %=\ %l\:\%L

" fzf
nnoremap <C-f> :Files<CR>
nnoremap <C-h> :History:<CR>

" nerdcommenter
vnoremap <ff> :call nerdcommenter#Comment('x', 'toggle')<CR>

" hexkinase
let g:Hexokinase_highlighters = ['backgroundfull']

" keymap
vnoremap <Tab> >gv
nnoremap <nn> :set nonumber<CR>
nnoremap <sn> :set number<CR>
