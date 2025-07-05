return {
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    build = ':TSUpdate',
    -- event = 'BufRead',
    lazy = false,
    opts = {
      -- ensure_installed = "all",
      sync_install = false,
      highlight = {
        -- too slow for large files, so off by default except for certain languages
        -- that don't have semantic highlighting with their LSPs
        -- enable = true,
        -- disable = function(lang, _)
        --   -- enable all except these languages
        --   return lang == 'python'
        -- end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      rainbow = { enable = false },
      playground = { enable = false },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true

      local parsers = require('nvim-treesitter.parsers')
      local configs = parsers.get_parser_configs()
      local all_langs = vim.tbl_keys(configs)

      local blacklist = {
        'ipkg' -- idris repo no longer exists
      }

      local function contains(t, x)
        for _, v in pairs(t) do if v == x then return true end end
        return false
      end

      local langs_to_install = vim.tbl_filter(
        function(lang) return not contains(blacklist, lang) end,
        all_langs)

      opts.ensure_installed = langs_to_install
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
