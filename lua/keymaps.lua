vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = '[w]rite buffer' })
vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>', { desc = '[c]lose buffer' })
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'clear highlight on search' })
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'open parent directory' })
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>', { desc = 'exit terminal mode' })

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'next [t]odo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'previous [t]odo comment' })

require('which-key').add {
  { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
  { '<leader>l', group = '[L]SP', mode = { 'n', 'v' } },
  { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
  { '<leader>r', group = '[R]ust crates', mode = { 'n', 'v' } },
  { '<leader>j', group = '[J]ava', mode = { 'n', 'v' } },
}

local telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader>s.', telescope.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
vim.keymap.set('n', '<leader>sd', telescope.diagnostics, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = '[s]earch by [g]rep' })
vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sr', telescope.resume, { desc = '[s]earch [r]esume' })
vim.keymap.set('n', '<leader>sR', telescope.registers, { desc = '[s]earch [R]egisters' })
vim.keymap.set('n', '<leader>ss', telescope.builtin, { desc = '[s]earch [s]elect Telescope' })
vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = '[s]earch [t]odo' })
vim.keymap.set('n', '<leader>sw', telescope.grep_string, { desc = '[s]earch current [w]ord' })

vim.keymap.set('n', '<leader>gb', telescope.git_branches, { desc = '[g]it: [b]ranches' })
vim.keymap.set('n', '<leader>gf', telescope.git_bcommits, { desc = '[g]it: [f]ile commit history' })
vim.keymap.set('n', '<leader>gh', telescope.git_commits, { desc = '[g]it: project commit [h]istory' })
vim.keymap.set('n', '<leader>gs', telescope.git_stash, { desc = '[g]it: [s]tashes' })
vim.keymap.set('n', '<leader>gt', telescope.git_status, { desc = '[g]it: s[t]atus' })

vim.keymap.set('n', '<leader>sp', function()
  require('telescope').extensions.repo.list { search_dirs = { '~/workspace' } }
end, { desc = '[s]earch in workspace [p]rojects' })

vim.keymap.set('n', '<leader><leader>', function()
  telescope.buffers {
    sort_mru = true,
    ignore_current_buffer = true,
  }
end, { desc = 'find existing buffers' })

vim.keymap.set('n', '<leader>/', function()
  telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sc', function()
  telescope.colorscheme {
    enable_preview = true,
  }
end, { desc = '[s]earch [c]olor scheme' })

vim.keymap.set('v', '<leader>sg', "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<cr>", { desc = '[s]earch by [g]rep the selection' })
