-- loaded via init.lua

-- save on focus lost
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
  callback = function()
    vim.cmd.stopinsert()
    vim.cmd.wall({ mods = { silent = true } })
  end,
})

-- restore-cursor h: last-position-jump
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = '*',
  callback = function()
    local ft = vim.opt_local.filetype:get()
    -- don't restore for git messages
    if ft:match('commit') or ft:match('rebase') then
      return
    end
    -- check if the " mark exists and jump to it
    local markpos = vim.api.nvim_buf_get_mark(0, '"')
    local line = markpos[1]
    local col = markpos[2]
    if line > 1 and line <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { line, col })
    end
  end,
})

-- roslyn codelens
-- see :h vim.lsp.codelense.refresh()
vim.api.nvim_create_autocmd({'BufEnter', 'CursorHold', 'InsertLeave'}, {
  pattern = { '*{.cs,.fs}' },
  callback = function()
    vim.lsp.codelens.refresh({ bufnr = 0 })
  end,
})

-- pico-8
vim.api.nvim_create_autocmd({'BufNew', 'BufEnter'}, {
  pattern = { '*.p8' },
  callback = function(args)
    vim.lsp.start({
      name = 'pico8-ls',
      cmd = { 'pico8-ls', '--stdio' },
      root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
      -- Setup your keybinds in the on_attach function
      on_attach = on_attach,
    })
  end
})
