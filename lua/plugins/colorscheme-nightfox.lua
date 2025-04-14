return {
  'EdenEast/nightfox.nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'dawnfox'

    -- Configure highlights
    vim.cmd.hi 'Comment gui=none'
  end,
  opts = {},
}
