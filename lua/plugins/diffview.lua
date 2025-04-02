-- Diffs for git revisions
return {
  'sindrets/diffview.nvim',
  keys = {
    { '<leader>gf', '<cmd>DiffviewFileHistory<cr>', desc = '[g]it: [f]ile commit history' },
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[g]it: [d]iff view' },
  },
  opts = {},
}
