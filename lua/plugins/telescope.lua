return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        -- `cond` is a condition used to determine whether this plugin should be installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[s]earch [f]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[s]earch by [g]rep' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
      vim.keymap.set('n', '<leader>sR', builtin.registers, { desc = '[s]earch [R]egisters' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[s]earch [s]elect Telescope' })
      vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<CR>', { desc = '[s]earch [t]odo' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })

      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[g]it: [b]ranches' })
      vim.keymap.set('n', '<leader>gf', builtin.git_bcommits, { desc = '[g]it: [f]ile commit history' })
      vim.keymap.set('n', '<leader>gh', builtin.git_commits, { desc = '[g]it: project commit [h]istory' })
      vim.keymap.set('n', '<leader>gs', builtin.git_stash, { desc = '[g]it: [s]tashes' })
      vim.keymap.set('n', '<leader>gt', builtin.git_status, { desc = '[g]it: s[t]atus' })

      vim.keymap.set('n', '<leader><leader>', function()
        builtin.buffers {
          sort_mru = true,
          ignore_current_buffer = true,
        }
      end, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>sc', function()
        builtin.colorscheme {
          enable_preview = true,
        }
      end, { desc = '[s]earch [c]olor scheme' })
    end,
  },
}
