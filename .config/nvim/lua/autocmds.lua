-- loaded via init.lua

-- Save on focus lost
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
  callback = function()
    vim.cmd.stopinsert()
    vim.cmd.wall({ mods = { silent = true }})
  end,
})

