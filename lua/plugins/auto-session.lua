return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>se', '<cmd>SessionSearch<CR>', desc = '[s]earch s[e]ssion' },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {},
}
