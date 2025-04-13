return {
  {
    "luisiacc/gruvbox-baby",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_baby_keyword_style = "italic"
      vim.g.gruvbox_baby_background_color = "dark"
      vim.cmd.colorscheme("gruvbox-baby")
    end,
  },

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("tokyonight").setup({
  --       style = "day"
  --     })
  --     vim.o.background = "light"
  --     vim.cmd.colorscheme("tokyonight")
  --   end,
  -- },
}
