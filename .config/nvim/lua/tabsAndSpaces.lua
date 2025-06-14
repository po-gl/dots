-- loaded via init.lua

vim.o.tabstop = 4        -- visual spaces per tab
vim.o.softtabstop = 4    -- number of spaces inserted when editing
vim.o.shiftwidth = 4     -- indentation level
vim.o.expandtab = true   -- treat tabs as spaces
vim.o.autoindent = true
vim.o.smartindent = true

-- Create tabs and spaces autocommand
function create_tas_autocmd (pattern, tabstop, softtabstop, shiftwidth)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = pattern,
    callback = function()
      vim.o.tabstop = tabstop
      vim.o.softtabstop = softtabstop
      vim.o.shiftwidth = shiftwidth
    end,
  })
end
create_tas_autocmd('python', 4, 4, 4)
create_tas_autocmd('css', 4, 4, 4)

create_tas_autocmd('lua', 2, 2, 2)
create_tas_autocmd('bash', 2, 2, 2)
create_tas_autocmd('zsh', 2, 2, 2)
create_tas_autocmd('c', 2, 2, 2)
create_tas_autocmd('cpp', 2, 2, 2)
create_tas_autocmd('html', 2, 2, 2)
create_tas_autocmd('javascript', 2, 2, 2)
create_tas_autocmd('typescript', 2, 2, 2)
create_tas_autocmd('json', 2, 2, 2)
create_tas_autocmd('sshconfig', 2, 2, 2)
