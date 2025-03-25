set tabstop=4        " Set tab width to 4 spaces
set shiftwidth=4     " Set indentation width to 4 spaces
set softtabstop=4    " Use 4 spaces per tab stop
set expandtab        " Use spaces instead of tabs

call plug#begin()

" List your plugins here
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'LeBarbu/vim-epitech'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

nnoremap <C-o> :NERDTreeToggle<CR>
