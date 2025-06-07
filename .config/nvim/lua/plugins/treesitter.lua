return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    -- event = 'BufRead',
    lazy = false,
    opts = {
      ensure_installed = "all",
      sync_install = false,
      highlight = {
        -- too slow for large files, so off by default except for certain languages
        -- that don't have semantic highlighting with their LSPs
        enable = true,
        disable = function(lang, _)
          -- disable all except these languages
          return lang == 'python'
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
