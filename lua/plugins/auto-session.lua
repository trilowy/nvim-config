return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>se', '<cmd>SessionSearch<CR>', desc = '[S]earch S[e]ssion' },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {},
}
