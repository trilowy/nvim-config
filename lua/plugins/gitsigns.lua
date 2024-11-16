return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      -- Navigation
      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { buffer = bufnr, desc = 'git: next [c]hange' })

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { buffer = bufnr, desc = 'git: previous [c]hange' })

      -- Actions
      vim.keymap.set('n', '<leader>ga', gitsigns.stage_hunk, { buffer = bufnr, desc = '[g]it: [a]dd hunk (stage)' })
      vim.keymap.set('v', '<leader>ga', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { buffer = bufnr, desc = '[g]it: [a]dd hunk (stage)' })
      vim.keymap.set('n', '<leader>gA', gitsigns.stage_buffer, { buffer = bufnr, desc = '[g]it: [A]dd buffer (stage)' })

      vim.keymap.set('n', '<leader>gB', gitsigns.blame_line, { buffer = bufnr, desc = '[g]it: [b]lame line' })

      vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { buffer = bufnr, desc = '[g]it: [d]iff against index' })
      vim.keymap.set('n', '<leader>gD', function()
        gitsigns.diffthis '@'
      end, { buffer = bufnr, desc = '[g]it: [D]iff against last commit' })

      vim.keymap.set('n', '<leader>ge', gitsigns.toggle_deleted, { buffer = bufnr, desc = '[g]it: toggle git show d[e]leted' })
      vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { buffer = bufnr, desc = '[g]it: [p]review hunk' })

      vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { buffer = bufnr, desc = '[g]it: [r]eset hunk' })
      vim.keymap.set('v', '<leader>gr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { buffer = bufnr, desc = '[g]it: [r]eset hunk' })
      vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { buffer = bufnr, desc = '[g]it: [R]eset buffer' })

      vim.keymap.set('n', '<leader>gT', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = '[g]it: [T]oggle show blame line' })
      vim.keymap.set('n', '<leader>gu', gitsigns.undo_stage_hunk, { buffer = bufnr, desc = '[g]it: [u]ndo stage hunk' })
    end,
  },
}
