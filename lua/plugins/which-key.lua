return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      spec = {
        {
          -- Document existing key chains
          { '<leader>g', group = '[G]it' },
          { '<leader>g_', hidden = true },
          { '<leader>l', group = '[L]SP' },
          { '<leader>l_', hidden = true },
          { '<leader>s', group = '[S]earch' },
          { '<leader>s_', hidden = true },
          -- visual mode
          { '<leader>g', group = '[G]it', mode = 'v' },
          { '<leader>s', group = '[S]earch', mode = 'v' },
        },
      },
    },
  },
}
