return {
  'nvim-neotest/neotest',

  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Adapters
    'nvim-neotest/neotest-plenary',
    'rcasia/neotest-java',
  },

  opts = function()
    return {
      adapters = {
        require('neotest-plenary').setup {
          min_init = vim.fn.stdpath 'data' .. '/lazy/plenary.nvim/tests/minimal_init.vim',
        },
        require 'neotest-java' {
          ignore_wrapper = false,
          -- Run the following command to download JUnit jar: `:NeotestJava setup`
        },
      },
    }
  end,

  config = function(_, opts)
    -- Better diagnostic message
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          return diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
        end,
      },
    }, neotest_ns)

    require('neotest').setup(opts)
  end,

  keys = {
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = '[t]est: run [l]ast test',
    },
    {
      '<leader>tn',
      function()
        require('neotest').run.run()
      end,
      desc = '[t]est: run [n]earest',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = '[t]est: show [o]utput',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = '[t]est: toggle [O]utput panel',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = '[t]est: toggle [s]ummary',
    },
    {
      '<leader>tS',
      function()
        require('neotest').run.stop()
      end,
      desc = '[t]est: [S]top',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = '[t]est: run [t]est file',
    },
    {
      '<leader>tT',
      function()
        require('neotest').run.run(vim.loop.cwd())
      end,
      desc = '[t]est: run all [T]est files',
    },
  },
}
