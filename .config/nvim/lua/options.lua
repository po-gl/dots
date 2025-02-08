-- loaded via init.lua

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.o.syntax = 'on'

vim.o.number = true
vim.o.relativenumber = true

vim.o.spell = true

vim.o.cursorline = true
vim.o.colorcolumn = "80"

vim.o.signcolumn = 'yes'

vim.o.updatetime = 100

-- highlight matching parentheses
vim.o.showmatch = true

vim.o.encoding = 'utf8'

vim.o.wrap = true
vim.o.linebreak = true

-- show results while typing
vim.o.incsearch = true
vim.o.ignorecase = true

vim.o.undofile = true
vim.o.undodir = vim.fn.expand('$HOME/.config/nvim/undo')

vim.o.splitbelow = true
vim.o.splitright = true

-- group words connected with dashes
vim.opt.iskeyword:append("-")

-- vim.o.backspace = 'eol,indent,start'

-- improved regex
vim.o.magic = true

-- visual autocomplete for command menu
vim.o.wildmenu = true

vim.o.lazyredraw = true

-- share yank/paste between instances (useful with tmux)
vim.o.clipboard = 'unnamedplus'

-- codeium
vim.g.codeium_enabled = 'v:false'
vim.g.codeium_tab_fallback = '\t'
-- vim.keymap.set('i', '<tab>', 'codeium#Accept()', { silent = true, expr = true }) -- TODO check if codeium is enabled first

-- vim-tests
vim.g["test#cpp#catch2#make_command"] = "make -j $(sysctl -n hw.physicalcpu)"
vim.g["test#cpp#catch2#file_pattern"] = "\\v[tT]est[s].*(\\.cpp)$"
