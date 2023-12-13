set shell=zsh
set encoding=UTF-8
set guifont=mononoki\ Nerd\ Font
set list lcs=tab:▸\ ,eol:↲,trail:~,precedes:«,extends:» " Set characters
set laststatus=3
" Remaps
:imap jj <Esc>
let mapleader=" "

" vim settings
set path+=**
set expandtab
set nowrap
set smartindent
set autoindent
set incsearch
set noswapfile
set nobackup
set undodir=~/.config/undodir
set undofile
set showmatch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nu
set signcolumn=yes
set relativenumber
set scrolloff=12
set noerrorbells
set nohlsearch
set colorcolumn=80
" set autochdir

highlight Normal guibg=none
" Not working?
highlight WinSeparator guibg=none


syntax on
set mouse=a
set cursorline
