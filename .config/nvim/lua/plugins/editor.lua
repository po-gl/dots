return {
  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- assistant
  { 'Exafunction/codeium.vim', enabled = true, },
  { 'github/copilot.vim', enabled = false, },

  -- commenter
  { 'tpope/vim-commentary' },

  -- expand regions + to expand, _ to shrink
  { 'terryma/vim-expand-region' },

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
    end,
  },
}
