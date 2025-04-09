-- Show keymaps while typing them
-- https://github.com/folke/which-key.nvim
return {
  'folke/which-key.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  event = 'VeryLazy',
  opts = {},
}
