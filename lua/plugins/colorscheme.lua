return {
  {
    -- To see what colorschemes are installed: `:Telescope colorscheme`.
    -- 'folke/tokyonight.nvim',
    -- 'tanvirtin/monokai.nvim',
    -- 'sainnhe/sonokai',
    -- 'glepnir/zephyr-nvim',
    -- 'ayu-theme/ayu-vim',
    'rebelot/kanagawa.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'kanagawa-wave' --'tokyonight-moon'

      -- Configure highlights
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
