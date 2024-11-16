return {
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
        { '<leader>r', group = '[R]ust crates' },
        { '<leader>r_', hidden = true },
        { '<leader>j', group = '[J]ava' },
        { '<leader>j_', hidden = true },
        { '<leader>t', group = '[T]est' },
        { '<leader>t_', hidden = true },
        -- visual mode
        { '<leader>g', group = '[G]it', mode = 'v' },
        { '<leader>s', group = '[S]earch', mode = 'v' },
        { '<leader>r', group = '[R]ust crates', mode = 'v' },
      },
    },
  },
}
