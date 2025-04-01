require('lazy').setup {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive', -- Git
  -- To see what colorschemes are installed: `:Telescope colorscheme`.
  require 'plugins.colorscheme-kanagawa',
  require 'plugins.colorscheme-tokyonight',
  require 'plugins.colorscheme-nightfox',
  require 'plugins.gitsigns',
  require 'plugins.which-key',
  require 'plugins.telescope',
  require 'plugins.neo-tree',
  require 'plugins.treesitter',
  require 'plugins.lspconfig',
  require 'plugins.cmp',
  require 'plugins.conform',
  require 'plugins.todo-comments',
  require 'plugins.mini',
  require 'plugins.lualine',
  require 'plugins.crates',
  require 'plugins.none-ls',
  require 'plugins.dressing',
  require 'plugins.auto-session',
  require 'plugins.rooter',
  require 'plugins.jdtls',
  require 'plugins.neotest',
}
