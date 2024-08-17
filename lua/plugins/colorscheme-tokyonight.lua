return {
  {
    -- To see what colorschemes are installed: `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    -- 'tanvirtin/monokai.nvim',
    -- 'sainnhe/sonokai',
    -- 'glepnir/zephyr-nvim',
    -- 'ayu-theme/ayu-vim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-moon'

      -- Configure highlights
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
