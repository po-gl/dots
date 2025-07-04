return {
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local lspconfig = require('lspconfig')
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

      -- Swift's SourceKit-LSP is installed with the swift toolchain (not mason)
      lspconfig.sourcekit.setup {
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            }
          }
        }
      }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = true,
    opts = {
      auto_update = false,
      run_on_start = true,
      ensure_installed = {
        -- LSPs
        'lua_ls',
        'basedpyright',
        'ruff', -- python linter and formatter
        'rust_analyzer',
        'gopls',
        'clangd',
        'zls', -- zig
        'cmake',
        -- 'csharp_ls',
        'omnisharp',
        -- 'tsserver',
        'jdtls', -- java
        'bashls',
        'html',
        'emmet_ls',
        'eslint-lsp', -- javascript, typescript
        'cssls',
        'jsonls',
        'yamlls',
        'taplo',   -- TOML
        'lemminx', -- XML
        'dockerls',
        'docker-compose-language-service',
        'graphql-language-service-cli',
        -- 'gleam',
        -- 'ltex',
        'marksman',
        -- 'grammarly-languageserver', -- wild
        -- 'nil_ls', -- Nix
        -- 'spectral', -- OpenAPI
        -- 'ruby_ls',
        'sqlls',
        'pico8_ls',

        -- linters
        -- 'pylint', -- (using ruff)
        -- 'es_lintd', -- javascript, typescript (using lsp)
        'swiftlint',
        -- 'bacon', -- rust (using lsp)
        'shellcheck',           -- bash
        'editorconfig-checker', -- this might get annoying
        -- 'sonarlint-language-server', -- sonarqube?
        'textlint',             -- text and markdown
        'typos',                -- general code spellchecker
        'kube-linter',

        -- formatters
        'black',     -- Python lsp
        'prettierd', -- javascript, html, css, json, etc.
        'clang-format',
        'gofumpt',
        'taplo',
        'yamlfix',
      },
    },
  },

  -- a package manager for lsp servers, dap servers, linters, and formatters
  {
    'williamboman/mason.nvim',
    lazy = true,
    config = function()
      require("mason").setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
    opts = {
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
        ['clangd'] = function()
          local nvim_lsp = require('lspconfig')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          nvim_lsp.clangd.setup({
            capabilities = capabilities,
            cmd = {
              'clangd',
              '-j=8',
              '--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++',
              '--clang-tidy',
              '--clang-tidy-checks=*',
              '--all-scopes-completion',
              '--cross-file-rename',
              '--completion-style=detailed',
              '--header-insertion-decorators',
              '--header-insertion=iwyu',
              '--pch-storage=memory',
            },
          })
        end,
        ['omnisharp'] = function()
          local nvim_lsp = require('lspconfig')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          local omnisharp_bin = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll"
          nvim_lsp.omnisharp.setup({
            capabilities = capabilities,
            -- cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
            cmd = { "dotnet", omnisharp_bin },
            enable_import_completion = true,
            organize_imports_on_format = true,
            enable_roslyn_analyzers = true,
            root_dir = function(fname)
              local solution = nvim_lsp.util.root_pattern("*.sln")(fname)
              local project = nvim_lsp.util.root_pattern("*.csproj")(fname)
              return solution or project
            end,
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
    lazy = true,
    config = function()
      local cmp = require('cmp')
      local compare = cmp.config.compare
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').load({ paths = { './snippets' } })

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<cr>'] = cmp.mapping.confirm({ select = true }),
          ['<c-space>'] = cmp.mapping.complete(),
          ['<c-u>'] = cmp.mapping.scroll_docs(-4),
          ['<c-d>'] = cmp.mapping.scroll_docs(4),
          ["<c-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<c-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip',                priority = 10 },
        }, {
          { name = 'buffer', keyword_length = 4 },
        }),
        sorting = {
          priority_weight = 1.0,
          comparators = {
            compare.locality,
            compare.recently_used,
            compare.score,
            compare.offset,
            compare.order,
            -- compare.exact,
            -- compare.sort_text,
            -- compare.kind,
            -- compare.length,
          },
        },
      })
    end,
  },

  -- snippets
  {
    'L3MON4D3/LuaSnip',
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip"
    },
  },

  -- symbol outline
  {
    "hedyhli/outline.nvim",
    config = function()
      require("outline").setup()
    end,
  },

  -- extra highlighting
  {
    "tikhomirov/vim-glsl"
  },

  {
    "neovimhaskell/haskell-vim"
  },
}
