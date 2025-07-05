return {
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    after = 'mason-lspconfig.nvim',
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
          border = 'rounded',
        }
      )
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          virtual_text = true,
        }
      )

      -- cross-reference names in
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

      -- go
      lspconfig.gopls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true
          }
        },
        root_dir = lspconfig.util.root_pattern('go.mod', '.git'),
        single_file_support = false,
      })

      -- rust
      lspconfig.rust_analyzer.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      -- python
      lspconfig.basedpyright.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      -- javascript
      lspconfig.eslint.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      -- zig
      lspconfig.zls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      -- lua_ls
      lspconfig.lua_ls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        root_dir = require('lspconfig.util').root_pattern('.git', '.'),
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })

      -- clangd
      lspconfig.clangd.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
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

      -- dotnet (csharp)
      -- using the seblyng/roslyn.nvim plugin
      -- so... not setting it up through lspconfig, see below
      -- btw getting the architecture right is critical here, "neutral" wasted a lot of my time
      local roslynpath = vim.fn.expand('$HOME/.nuget/LanguageServer/osx-arm64')
      vim.env.PATH = vim.env.PATH .. ':' .. roslynpath
      vim.lsp.config('roslyn', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        cmd = {
          'dotnet',
          roslynpath .. '/Microsoft.CodeAnalysis.LanguageServer.dll',
          '--logLevel',
          'Information',
          '--extensionLogDirectory',
          '/tmp/roslyn_ls/logs',
          '--stdio',
        },
        settings = {
          ["csharp|background_analysis"] = {
            background_analysis = {
              dotnet_analyzer_diagnostics_scope = "openFiles",
              dotnet_compiler_diagnostics_scope = "fullSolution",
            },
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
        }
      })

      -- markdown
      lspconfig.marksman.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      -- bash
      lspconfig.bashls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      -- yaml
      lspconfig.yamlls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      -- swift
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
        -- 'omnisharp', -- (using roslyn instead, not through mason)
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
    config = function()
      require('mason').setup()
      local data_path = vim.fn.stdpath('data')
      vim.env.PATH = vim.env.PATH .. ':' .. data_path .. '/mason/bin'
    end,
  },
  -- for some reason the mason-lspconfig handlers were breaking things,
  -- so I'll just be manually configuring settings in native lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    after = {
      'mason.nvim',
      'mason-tool-installer.nvim',
    },
  },

  -- special little roslyn
  -- see instructions for setting up roslyn, including downloading
  -- Microsoft.CodeAnalysis.LanguageServer.neutral nuget package
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#roslyn_ls
  {
    'seblyng/roslyn.nvim',
    ft = 'cs,fs',
    ---@modlue 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      choose_target = function(target)
        return vim.iter(target):find(function(item)
          if string.match(item, '.sln$') then
            return item
          end
        end)
      end
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
      local compare = cmp.config.compare
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').load({ paths = { './snippets' } })

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
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
          ['<c-n>'] = cmp.mapping(function(fallback)
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
          end, { 'i', 's' }),

          ['<c-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
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
    dependencies = {
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip'
    },
  },

  -- symbol outline
  {
    'hedyhli/outline.nvim',
    config = function()
      require('outline').setup()
    end,
  },

  -- extra highlighting
  {
    'tikhomirov/vim-glsl',
    lazy = true,
    ft = 'glsl',
  },

  {
    'neovimhaskell/haskell-vim',
    lazy = true,
    ft = 'hs',
  },
}
