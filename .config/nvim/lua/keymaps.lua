-- loaded via init.lua

-- quick save
vim.keymap.set('n', 'ges', '<cmd>w<cr>')

-- highlight last inserted text
vim.keymap.set('n', 'gV', '`[v`]')

-- toggle folds
vim.keymap.set('n', '<space><space>', 'za')

-- toggle tree
-- vim.keymap.set('n', 'gw', '<cmd>NvimTreeToggle<cr>') -- set as lazy-load key mapping

-- multi-window movement
-- set via 'nvim-tmux-navigation' plugin
-- vim.keymap.set('n', '<c-j>', '<c-w>j')
-- vim.keymap.set('n', '<c-k>', '<c-w>k')
-- vim.keymap.set('n', '<c-h>', '<c-w>h')
-- vim.keymap.set('n', '<c-l>', '<c-w>l')

-- jump to last buffer
vim.keymap.set('n', '<c-p>', '')

-- tabs
vim.keymap.set('n', '<a-left>', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<a-right>', '<cmd>tabnext<cr>')

-- split to new tab
vim.keymap.set('n', '<C-w>t', '<cmd>tab split<cr>')
-- <C-w>v should be vsplit tab

-- expand regions
-- default keybindings are + to expand, _ to shrink

-- fuzzy search <leader> maps to \ by default
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- diff view
vim.keymap.set('n', '<leader>dt', function()
  if next(require('diffview.lib').views) == nil then
    vim.cmd('DiffviewOpen')
  else
    vim.cmd('DiffviewClose')
  end
end)

-- vim-gitgutter
vim.keymap.set('n', ']h', '<cmd>GitGutterNextHunk<cr>')
vim.keymap.set('n', '[h', '<cmd>GitGutterPrevHunk<cr>')

-- refactoring
-- set as lazy-load key mapping
vim.keymap.set({ 'n', 'x' }, '<leader>re', ':Refactor extract<space>')
vim.keymap.set({ 'n', 'x' }, '<leader>rf', ':Refactor extract_to_file<space>')
vim.keymap.set({ 'n', 'x' }, '<leader>rv', ':Refactor extract_var<space>')
vim.keymap.set('n', '<leader>ri', ':Refactor inline_var<space>')
vim.keymap.set('n', '<leader>rI', ':Refactor inline_func<space>')
vim.keymap.set('n', '<leader>rb', ':Refactor extract_block<space>')
vim.keymap.set('n', '<leader>rbf', ':Refactor extract_block_to_file<space>')
vim.keymap.set({ 'n', 'x' }, '<leader>rr', function() require('telescope').extensions.refactoring.refactors() end)

-- testing
vim.keymap.set('n', '<leader>t', '<cmd>TestNearest<cr>', { silent = true })
vim.keymap.set('n', '<leader>T', '<cmd>TestFile<cr>', { silent = true })
vim.keymap.set('n', '<leader>ta', '<cmd>TestSuite<cr>', { silent = true })
vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<cr>', { silent = true })
vim.keymap.set('n', '<leader>tg', '<cmd>TestVisit<cr>', { silent = true })

-- quick fix
-- ]q and [q for :cnext and :cprev
vim.keymap.set('n', '<leader>cq', '<cmd>cclose<cr>')
vim.keymap.set('n', '<leader>co', '<cmd>copen<cr>')

-- lsp
-- these settings can be global
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.keymap.set('n', '<leader>i', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- signature overloads (set per lsp in lsp.lua)
-- <Alt-n> <Alt-p> for next/prev signature
-- <Alt-.> <Alt-,> for next/prev parameter
-- <Alt-c> to close completion menu that's probably in the way


-- the rest need to be added after the lsp attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover({
        border = 'rounded'
      })
    end, opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

    vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>f=', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- symbol outline
vim.keymap.set('n', '<leader>o', '<cmd>Outline<cr>')
