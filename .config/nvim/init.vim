" Settings to share .vimrc between vim and neovim
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc
"" General {{{

syntax on
set number
set spell " spellcheck
set cursorline
set colorcolumn=80
set showmatch  " highlight matching parentheses

set wrap
set linebreak

set incsearch  " show results while typing

set undofile
set undodir=$HOME/.config/nvim/undo

set splitbelow
set splitright

set iskeyword +=-  " group words connected with dashes

set backspace=eol,indent,start

set magic  " improved regex

filetype plugin indent on  " enables file-type detection for indentation

set wildmenu  " visual autocomplete for command menu

set lazyredraw

"}}}
"" Plugins {{{
" Check .config/nvim/lua/plugins.lua
lua require('plugins')
"}}}
"" Keybindings {{{

" quick reload settings
" nnoremap ger :so ~/.config/nvim/init.vim<CR>
" quick save
nnoremap ges :w<CR>

" highlight last inserted text
nnoremap gV `[v`]

" Open/close folds with space
nnoremap <space> za

nnoremap gw :NvimTreeToggle<CR>

" Multi-window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Movement in terminal mode
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

"}}}
"" Colors {{{
set termguicolors
set background=dark
colorscheme gruvbox
"}}}
"" Tabs and Spaces {{{
set tabstop=2		" visual spaces per tab
set softtabstop=2	" number of spaces inserted when editing
set expandtab		" treat tabs as spaces
set autoindent      
set smartindent
set shiftwidth=2	" indentation level
"}}}
" vim:foldmethod=marker
