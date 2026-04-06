let mapleader = "\<Space>"
nnoremap <leader>pv :Ex<CR>

set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set number
set relativenumber
set colorcolumn=81
set cursorline
syntax on
filetype plugin indent on

augroup VimNixIndent
  autocmd!
  autocmd FileType nix setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END

set noswapfile
set undodir=$HOME/.vim/undodir
set undofile

highlight Visual ctermfg=white ctermbg=blue cterm=bold
