" Porter Glines vimrc
"" Vundle (Plugins) {{{

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'morhetz/gruvbox'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-airline/vim-airline'
Plugin 'Lokaltog/powerline'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'mattn/emmet-vim'
Plugin 'ternjs/tern_for_vim'
Plugin 'tpope/vim-surround'

" Plugin 'python-mode/python-mode'  " Currently broken due to python 3.7 issue

" Plugin 'terryma/vim-multiple-cursors' " kinda breaks

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
 " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

" }}}
" Custom Bindings {{{ 

" Aliases
" This will retab an entire file to have 2 spaces instead of 4 spaces
" command Retab4to2 %s;^\(\s\+\);\=repeat(' ', len(submatch(0))/2);g

" Open/close folds with space
nnoremap <space> za
" highlight the last inserted text
nnoremap gV `[v`]       
" jk is escape
inoremap jk <esc>
" quick save
nnoremap ges :w<CR>
" quick reload .vimrc
nnoremap ger :so ~/.vimrc<CR>
" Bindings for YouCompleteMe code completion
nnoremap gl :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Bindings for NERDTree
nnoremap gw :NERDTreeToggle<CR>

nnoremap gt :MinimapToggle<CR>

map <C-v><Esc>OA <up>
map <C-v><Esc>OB <down>
map <C-v><Esc>OC <right>
map <C-v><Esc>OD <left>



" }}}
" Colors {{{

" Gruvbox Theme
colorscheme gruvbox

" Paper Color Theme
" colorscheme PaperColor
"let g:PaperColor_Theme_Options = {
"    \   'theme': {
"    \       'default.light': {
"    \           'transparent_background': 1
"    \       }
"    \   }
"    \ }

" }}}
" UI {{{

syntax on               " Turn syntax highlighting on
set number              " show number lines
set cursorline          " highlight the current line
filetype plugin indent on   " enables filetype detection for indentation purposes
set wildmenu            " visual autocomplete for command menu
" set lazyredraw          " redraw less often
set showmatch           " highlight the matching (){}[]

" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Book:s12  " Necessary for Airline to look correct
" set guifont=Inconsolata\ for\ Powerline:h15
" set guifont=Source\ Code\ Pro\ for\ Powerline
" let g:Powerline_symbols = 'fancy'
" set encoding=utf-8
" set t_Co=256
" set fillchars+=stl:\ ,stlnc:\
" set term=xterm-256color
" set termencoding=utf-8

" }}}
" Airline {{{
" let g:airline_powerline_fonts = 1
" set guifont=Source\ Code\ Pro\ for\ Powerline:h10
" 
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" 
" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'
" 
" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" 
" " old vim-powerline symbols
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr = '⭡'

" }}}
" Statusline {{{
" Maybe convert to airline statusline

" function! GitBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction
" 
" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction
" 
" set laststatus=2        " Ensure statusline will be shown
" set statusline+=%#TabLineSel#
" " set statusline+=%{StatuslineGit()} " This sorta breaks scrolling for some
" " reason...
" set statusline+=%#LineNr#
" set statusline+=\ %f
" set statusline+=%m\
" set statusline+=%=
" set statusline+=%#CursorColumn#
" set statusline+=\ %l:%c
" set statusline+=\ %y
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\ [%{&fileformat}\]
" set statusline+=\ %p%%
" set statusline+=\ \ 

" }}}
" Tabs and Spaces {{{

set tabstop=2           " visual spaces per /t
set softtabstop=2       " number of spaces inserted when editing
set expandtab           " treat tabs as spaces (no /t)
set autoindent          " automatic indention 
set shiftwidth=2        " indention level

" }}}
" Windows {{{

" This lets me navigate windows with just
" 'CTRL+j' or 'CTRL+k' or others instead of
" 'CTRL+W j'
" Note that moving windows still requires
" CTRL+W
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" }}}
" Search {{{

set incsearch           " search as you type
"set hlsearch            " highlight matches

" }}}
" Folding {{{

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold is max

" }}}
" Other {{{
  
set linebreak     " Don't cut off word-wrapped words
set backspace=indent,eol,start
set modelines=1         " Check the last line of a file for Vim settings
if has('persistant_undo')
  set undofile
  set undodir=$HOME/.vim/undo
  endif

" }}}
" YouCompleteMe {{{

" When you need another language supported, recompile using
"     cd ~/.vim/bundle/YouCompleteMe
"     ./install.py 
" With the following flags:
"   --clang-completer       " C-family
"   --system-libclang       " C-family
"   --js-completer          " Javascript

" let g:ycm_global_ycm_extra_conf='.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycmd/cpp/ycm/.ycm_extra_conf.py'
" let g:ycm_complete_in_comments=1

" }}}
" Plugin Settings{{{

set runtimepath^=~/.vim/plugin/openurl.vim    " Plugin to open a URL with ':Ourl'

let g:minimap_highlight='Folded'
" autocmd vimenter * NERDTree

let g:pymode_python = 'python3'
let g:pymode_virtualenv = 0
let g:pymode_breakpoint = 0
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_run = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_lint_on_write = 1
"set the complexity check high to essentially disable it
let g:pymode_lint_options_mccabe = {'complexity': 30}

" }}}
" vim:foldmethod=marker:foldlevel=0
