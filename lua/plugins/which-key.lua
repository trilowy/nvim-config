return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      spec = {
        {
          -- Document existing key chains
          { '<leader>c', group = '[C]ode' },
          { '<leader>c_', hidden = true },
          { '<leader>d', group = '[D]ocument' },
          { '<leader>d_', hidden = true },
          { '<leader>r', group = '[R]ename' },
          { '<leader>r_', hidden = true },
          { '<leader>s', group = '[S]earch' },
          { '<leader>s_', hidden = true },
          { '<leader>W', group = '[W]orkspace' },
          { '<leader>W_', hidden = true },
          { '<leader>t', group = '[T]oggle' },
          { '<leader>t_', hidden = true },
          { '<leader>h', group = 'Git [H]unk' },
          { '<leader>h_', hidden = true },
          -- visual mode
          { '<leader>h', group = 'Git [H]unk', mode = 'v' },
        },
      },
    },
  },
}
