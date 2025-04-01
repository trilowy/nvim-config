-- Statusline
-- https://github.com/nvim-lualine/lualine.nvim
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  opts = {
    sections = {
      lualine_c = {
        {
          'filename',
          path = 1,
          symbols = {
            modified = '⬤',
            readonly = '🔒',
          },
        },
      },
      lualine_x = {
        'encoding',
        'fileformat',
        'filetype',
        {
          'lsp_status',
          icon = '',
          symbols = {
            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
            done = '✓',
            -- Delimiter inserted between LSP names
            separator = ' ',
          },
          -- LSP to ignore
          ignore_lsp = { 'null-ls', 'copilot' },
        },
      },
    },
    inactive_sections = {
      lualine_c = {
        {
          'filename',
          path = 1,
          symbols = {
            modified = '⬤',
            readonly = '🔒',
          },
        },
      },
    },
  },
}
