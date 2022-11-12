" settigns
set number
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'Everblush/everblush.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

" colorscheme
set termguicolors
colo everblush

" statusline
set laststatus=2
set statusline=%1*\ %f\ %=\ %l\:\%L

" plug settigns
let g:Hexokinase_highlighters = ['backgroundfull']

" keymaps
vnoremap <Tab> >gv
nnoremap nn :set nonumber<CR>
nnoremap sn :set number<CR>
vnoremap ff :call nerdcommenter#Comment('x', 'toggle')<CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-h> :History:<CR>
nnoremap co :HexokinaseToggle<CR>
