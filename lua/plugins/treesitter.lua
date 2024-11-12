return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'rust', 'gleam' },
      -- Automatically install missing parsers when entering buffer
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
