return {
  {
    'zbirenbaum/copilot.lua',
    opts = {},
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    config = function()
      require('CopilotChat').setup {}

      vim.keymap.set('n', '<leader>i', '<cmd>CopilotChatToggle<CR>', { desc = 'A[i] prompt chat' })
    end,
  },
}
