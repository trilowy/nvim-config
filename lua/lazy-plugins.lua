-- Install plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
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
  require 'plugins.oil',
  require 'plugins.dressing',
  require 'plugins.auto-session',
  require 'plugins.rooter',
  require 'plugins.jdtls',
  require 'plugins.neotest',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
