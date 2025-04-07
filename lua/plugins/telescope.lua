-- Fuzzy search
-- https://github.com/nvim-telescope/telescope.nvim
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    'cljoly/telescope-repo.nvim',
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }
    -- Popup in Telescope instead of native ones (e.g. LSP code actions)
    require('telescope').load_extension 'ui-select'
    -- More options for fuzzy finding
    require('telescope').load_extension 'fzf'
    -- Search projects
    require('telescope').load_extension 'repo'
  end,
}
