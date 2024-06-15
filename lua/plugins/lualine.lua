return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  opts = {
    sections = {
      lualine_c = {
        {
          'filename',
          path = 1,
        },
      },
    },
    inactive_sections = {
      lualine_c = {
        {
          'filename',
          path = 1,
        },
      },
    },
  },
}
