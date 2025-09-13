return {
  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        dynamic_preview_title = true,
        path_display = {
          shorten = {
            len = 3,
            exclude = {1, -1},
          },
        },
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            width = 0.95,
            height = 0.95,
            preview_width = 0.55,
            preview_cutoff = 120,
          },
          vertical = {
            width = 0.98,
            height = 0.98,
            preview_height = 0.40,
            preview_cutoff = 10,
          }
        },
      },
    },
  },

  -- assistant
  { 'Exafunction/codeium.vim', enabled = false, },
  { 'github/copilot.vim', enabled = false, },

  -- commenter
  { 'tpope/vim-commentary' },

  -- expand regions + to expand, _ to shrink
  { 'terryma/vim-expand-region' },

  -- auto-pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true
  },

  -- key binding helper
  { 'folke/which-key.nvim' },

  -- surround
  { 'tpope/vim-surround' },

  -- git wrapper
  { 'tpope/vim-fugitive' },
  { 'airblade/vim-gitgutter' },

  -- quick fix
  { 'stefandtw/quickfix-reflector.vim' },

  -- diff view
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- refactoring
  {
    'ThePrimeagen/refactoring.nvim',
    lazy = true,
    keys = {
      { '<leader>re', ':Refactor extract<space>', mode = { 'n', 'x' } },
      { '<leader>rf', ':Refactor extract_to_file<space>', mode = { 'n', 'x' } },
      { '<leader>rv', ':Refactor extract_var<space>', mode = { 'n', 'x' } },
      { '<leader>ri', ':Refactor inline_var<space>', mode = 'n' },
      { '<leader>rI', ':Refactor inline_func<space>', mode = 'n' },
      { '<leader>rb', ':Refactor extract_block<space>', mode = 'n' },
      { '<leader>rbf', ':Refactor extract_block_to_file<space>', mode = 'n' },
      { '<leader>rr', function() require('telescope').extensions.refactoring.refactors() end, mode = { 'n', 'x' }, },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      require('refactoring').setup({})
      require('telescope').load_extension('refactoring')
    end,
  },

  -- testing
  { 'vim-test/vim-test' },

  -- { 'cdelledonne/vim-cmake' },

  -- file exploring
  {
    'kyazdani42/nvim-tree.lua',
    lazy = true,
    keys = {
      { 'gw', '<cmd>NvimTreeToggle<cr>', mode = 'n', desc = 'Tree toggle' },
    },
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    opts = {
      -- on_attach = function(bufnr)
      --   local api = require('nvim-tree.api')

      --   local function opts(desc)
      --     return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      --   end

      --   api.config.mappings.default_on_attach(bufnr)

      --   vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
      --   vim.keymap.set('n', 'd', api.tree.change_root_to_node, opts('CD'))
      --   vim.keymap.set('n', '<space>', api.tree.toggle, opts('Toggle'))
      -- end,
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
    },
    config = function(_, opts)
      require('nvim-tree').setup(opts)
    end,
  },

  -- smooth scrolling
  {
    'karb94/neoscroll.nvim',
    enabled = false,
    config = function()
      local neoscroll = require('neoscroll')
      neoscroll.setup({
        easing_function = "sine"
      })

      local keymap = {
        ['<C-u>'] = function() neoscroll.ctrl_u({ duration = 100}) end;
        ['<C-d>'] = function() neoscroll.ctrl_d({ duration = 100}) end;
        ['<C-b>'] = function() neoscroll.ctrl_b({ duration = 200}) end;
        ['<C-f>'] = function() neoscroll.ctrl_f({ duration = 200}) end;
        ['<C-y>'] = function() neoscroll.scroll(-0.1, { move_cursor=false, duration = 100}) end;
        ['<C-e>'] = function() neoscroll.scroll(0.1, { move_cursor=false, duration = 100}) end;
        ['zt'] = function() neoscroll.zt({ half_win_duration = 200}) end;
        ['zz'] = function() neoscroll.zz({ half_win_duration = 200}) end;
        ['zb'] = function() neoscroll.zb({ half_win_duration = 200}) end;
      }
      local modes = { 'n', 'v', 'x' }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },

  -- pico 8 support
  {
    'bakudankun/pico-8.vim',
    lazy = true,
    ft = 'p8,lua'
  }
}
