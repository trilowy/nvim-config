-- Recover automatically the last session and opened buffers
-- https://github.com/rmagatti/auto-session
return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>se', '<cmd>SessionSearch<cr>', desc = '[s]earch s[e]ssion' },
  },
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {},
}
