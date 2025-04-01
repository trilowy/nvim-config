vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'next [t]odo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'previous [t]odo comment' })
