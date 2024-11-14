vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlight on search on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[w]rite buffer' })
vim.keymap.set('n', '<leader>c', '<cmd>bd<CR>', { desc = '[c]lose buffer' })
vim.keymap.set('n', '<A-o>', 'm`o<Esc>``', { desc = 'add empty line below' })
vim.keymap.set('n', '<A-O>', 'm`O<Esc>``', { desc = 'add empty line above' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'exit terminal mode' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'next [t]odo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'previous [t]odo comment' })
