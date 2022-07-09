" Settings to share .vimrc between vim and neovim
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc
"" General {{{

" syntax on
set number
set spell " spellcheck
set cursorline
set colorcolumn=80
set showmatch  " highlight matching parentheses

set encoding=utf8

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

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
" autocmd BufReadPost,FileReadPost * normal zR  " Auto open folds on open
"}}}
"" Keybindings {{{

" quick reload settings
nnoremap ger :so ~/.config/nvim/init.vim<CR>
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

" Fuzzy search
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Debugging
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>


"}}}
"" Colors {{{
set termguicolors
set background=dark
" colorscheme gruvbox
colorscheme gruvbox-baby
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
