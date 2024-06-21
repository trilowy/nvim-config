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
    opts = {
      colors = {
        palette = {
          -- See https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua for other color override
          sumiInk3 = '#0E0D18', -- Background
          sumiInk4 = '#151521', -- Darker foreground (line numbers, fold column, non-text characters), float borders
          sumiInk5 = '#222238', -- Current line
          waveBlue1 = '#334765', -- Popup background, visual selection background
        },
      },
    },
  },
}
