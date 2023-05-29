local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- nvim-tree keymap config
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'd', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<space>', api.tree.toggle, opts('Toggle'))
end



return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  --    use { 'neovim/nvim-lspconfig' } -- default lsp server

  -- Completion via coc
  use {'neoclide/coc.nvim', branch = 'release'}


  --    -- Completion vanilla neovim lsp
  --    use { 'ms-jpq/coq_nvim' }
  --    use { 'ms-jpq/coq.artifacts' }
  --    local lsp = require "lspconfig"
  --    local coq = require "coq"

  --    lsp.pyright.setup{}
  --    lsp.pyright.setup(coq.lsp_ensure_capabilities{})
  --    lsp.eslint.setup{}
  --    lsp.eslint.setup(coq.lsp_ensure_capabilities{})
  --    lsp.clangd.setup{}
  --    lsp.clangd.setup(coq.lsp_ensure_capabilities{})
  --    lsp.java_language_server.setup{}
  --    lsp.java_language_server.setup(coq.lsp_ensure_capabilities{})
  --    vim.cmd([[COQnow -s]])

  -- Color scheme
  use { 'luisiacc/gruvbox-baby',
    config = function()
      require('gruvbox-baby.colors').config()
    end
  }
  vim.g.gruvbox_baby_keyword_style = "italic"

  use { 'ellisonleao/gruvbox.nvim',
    config = function()
      require('gruvbox').setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          operators = true,
          comments = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        overrides = {},
      })
    end
  }

  -- File Exploring
  use { 'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require("nvim-tree").setup({
        on_attach = on_attach,
        sort_by = "case_sensitive",
        view = {
          adaptive_size = true,
          number = false,
        },
        renderer = {
          indent_markers = {
            enable = true,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
            },
          },
          icons = {
            show = {
              folder_arrow = false,
            },
          },
        },
      })
    end
  }

  -- Undo tree
  --    use { 'mbbill/undotree',
  --        cmd = 'UndotreeToggle',
  --        config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
  --    }


  use { "lukas-reineke/indent-blankline.nvim",
    config = function()
      require('indent_blankline').setup()
    end
  }

  -- Status bar
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      })
    end
  }

  -- Marks
  use { 'chentoast/marks.nvim',
    config = function()
      require('marks').setup({
        force_write_shada = true,
      })
    end
  }


  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all"
        ensure_installed = "all",
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          -- disable = { "c", "rust" },
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        }
      })
    end
  }


  -- Smooth scroll
  use { 'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({
        easing_function = "quadratic"
      })

      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '100'}}
      t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '100'}}
      t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '200'}}
      t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '200'}}
      t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
      t['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
      t['zt']    = {'zt', {'100'}}
      t['zz']    = {'zz', {'100'}}
      t['zb']    = {'zb', {'100'}}
      require('neoscroll.config').set_mappings(t)
    end
  }

  -- Fuzzy Search
  use { 'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Other fuzzy searcher
  -- use { 'junegunn/fzf', run = ":call fzf#install()" }
  -- use { 'junegunn/fzf.vim' }

  use { 'stefandtw/quickfix-reflector.vim' }

  -- Git wrapper
  use { 'tpope/vim-fugitive' }

  use { 'airblade/vim-gitgutter' }

  -- Commenter
  use { 'tpope/vim-commentary' }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Testing with vim-test
  use { 'vim-test/vim-test' }

  use { 'terryma/vim-expand-region' }

  -- use { 'github/copilot.vim' }
  use { 'Exafunction/codeium.vim' }

  -- Debugging with vimspector
  use { "puremourning/vimspector",
    cmd = { "VimspectorInstall", "VimspectorUpdate" },
    fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
    config = function()
      require("vimspector").setup()
    end,
  }

  --    -- Debugging
  --    use { 'nvim-lua/plenary.nvim' }
  --    use { 'mfussenegger/nvim-dap' }
  --    local dap = require('dap')
  --    dap.adapters.python = {
  --        type = 'executable';
  --        command = '/usr/local/bin/python3';
  --        args = { '-m', 'debugpy.adapter' };
  --    }
  --    dap.configurations.python = {
  --        {
  --            type = 'python';
  --            request = 'launch';
  --            name = "Launch file";
  --            program = "${file}";
  --            pythonPath = function()
  --                return '/usr/local/bin/python3'
  --            end;
  --        },
  --    }


  -- Language Specific Plugins --
  
  -- Go Development 
  use { 'fatih/vim-go' }

  -- Rust Development
  -- use { 'simrat39/rust-tools.nvim' }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugin
  if packer_bootstrap then
    require('packer').sync()
  end
end)

