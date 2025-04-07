-- Directory edition
-- https://github.com/stevearc/oil.nvim
return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
}
