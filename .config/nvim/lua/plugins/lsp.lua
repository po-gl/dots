return {
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {
          border = "rounded",
        }
      )
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          virtual_text = true,
        }
      )
    end,
  },

  -- a package manager for lsp servers, dap servers, linters, and formatters
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      -- Available LSP servers https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
      ensure_installed = {
        'lua_ls',
        'pyright',
        'rust_analyzer',
        'gopls',
        'clangd',
        'cmake',
        'tsserver',
        'eslint',
        'jdtls', -- java
        'bashls',
        'html',
        'emmet_ls',
        'cssls',
        'jsonls',
        'yamlls',
        'taplo', -- TOML
        'lemminx', -- XML
        'dockerls',
        'graphql',
        'docker_compose_language_service',
        'gleam',
        -- 'ltex',
        'marksman',
        -- 'nil_ls', -- Nix
        -- 'spectral', -- OpenAPI
        'ruby_ls',
        'sqlls',
      },
      handlers = {
        function(server)
          require('lspconfig')[server].setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          })
        end,
        ['gopls'] = function()
          local nvim_lsp = require('lspconfig')
          nvim_lsp.gopls.setup({
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true
              }
            },
            root_dir = nvim_lsp.util.root_pattern("go.mod", ".git"),
            single_file_support = false,
          })
        end,
        ['lua_ls'] = function()
          require('lspconfig').lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                }
              }
            }
          })
        end,
      },
    },
  },

  -- auto completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<cr>'] = cmp.mapping.confirm({ select = true }),
          ['<c-space>'] = cmp.mapping.complete(),
          ['<c-u>'] = cmp.mapping.scroll_docs(-4),
          ['<c-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }),
      })
    end,
  },

  -- snippets
  {
    'L3MON4D3/LuaSnip',
  },
}
