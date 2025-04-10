vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = '[w]rite buffer' })
vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>', { desc = '[c]lose buffer' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'next [q]uickfix' })
vim.keymap.set('n', '[q', '<cmd>cprev<cr>', { desc = 'previous [q]uickfix' })
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'clear highlight on search' })
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'open parent directory' })
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>', { desc = 'exit terminal mode' })
vim.keymap.set('n', '<leader>gg', '<cmd>Flog -all<cr>', { desc = '[g]it: [g]raph' })

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
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = '[g]it: [d]iff view' })
vim.keymap.set('n', '<leader>gf', '<cmd>DiffviewFileHistory<cr>', { desc = '[g]it: [f]ile commit history' })
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

local crates = require 'crates'
vim.keymap.set('n', '<leader>rt', crates.toggle, { silent = true, desc = '[r]ust crates: [t]oggle' })
vim.keymap.set('n', '<leader>rr', crates.reload, { silent = true, desc = '[r]ust crates: [r]eload' })
vim.keymap.set('n', '<leader>rv', crates.show_versions_popup, { silent = true, desc = '[r]ust crates: show [v]ersions' })
vim.keymap.set('n', '<leader>rf', crates.show_features_popup, { silent = true, desc = '[r]ust crates: show [f]eatures' })
vim.keymap.set('n', '<leader>rd', crates.show_dependencies_popup, { silent = true, desc = '[r]ust crates: show [d]ependencies' })
vim.keymap.set('n', '<leader>ru', crates.update_crate, { silent = true, desc = '[r]ust crates: [u]pdate' })
vim.keymap.set('v', '<leader>ru', crates.update_crates, { silent = true, desc = '[r]ust crates: [u]pdate' })
vim.keymap.set('n', '<leader>rU', crates.upgrade_crate, { silent = true, desc = '[r]ust crates: [U]pgrade' })
vim.keymap.set('v', '<leader>rU', crates.upgrade_crates, { silent = true, desc = '[r]ust crates: [U]pgrade' })
vim.keymap.set('n', '<leader>rA', crates.upgrade_all_crates, { silent = true, desc = '[r]ust crates: upgrade [A]ll crates' })
vim.keymap.set('n', '<leader>rx', crates.expand_plain_crate_to_inline_table, { silent = true, desc = '[r]ust crates: e[x]pand to inline table' })
vim.keymap.set('n', '<leader>rX', crates.extract_crate_into_table, { silent = true, desc = '[r]ust crates: e[X]tract into table' })
vim.keymap.set('n', '<leader>rH', crates.open_homepage, { silent = true, desc = '[r]ust crates: [H]omepage' })
vim.keymap.set('n', '<leader>rR', crates.open_repository, { silent = true, desc = '[r]ust crates: [R]epository' })
vim.keymap.set('n', '<leader>rD', crates.open_documentation, { silent = true, desc = '[r]ust crates: [D]ocumentation' })
vim.keymap.set('n', '<leader>rC', crates.open_crates_io, { silent = true, desc = '[r]ust crates: open [C]rates.io' })

vim.keymap.set('n', '<leader>ave', '<cmd>silent !ansible-vault encrypt %<CR>', { desc = '[a]nsible-[v]ault [e]ncrypt' })
vim.keymap.set('n', '<leader>avd', '<cmd>silent !ansible-vault decrypt %<CR>', { desc = '[a]nsible-[v]ault [d]ecrypt' })
vim.keymap.set('n', '<leader>hv', '<cmd>silent !helm-vault -f ~/credentials/helm-vault-pass -i %<CR>', { desc = '[h]elm-[v]ault encrypt/decrypt' })

vim.keymap.set('n', '<leader>i', '<cmd>CopilotChatToggle<CR>', { desc = 'A[i] prompt chat' })
