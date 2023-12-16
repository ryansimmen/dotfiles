call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'myusuf3/numbers.vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

colorscheme molokai
set ignorecase
let mapleader = ","
nnoremap <leader>ev :tabnew ~/.vimrc<CR>

set number
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>
let g:enable_numbers = 0

map <C-n> :NERDTreeToggle<CR>

set updatetime=100

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
