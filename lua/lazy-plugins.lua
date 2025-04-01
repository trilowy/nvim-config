-- ====================
-- || Plugin manager ||
-- ====================

-- Install Lazy plugin manager
-- https://lazy.folke.io
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- =============
-- || Plugins ||
-- =============

require('lazy').setup {
  -- Colorscheme that will be used when installing plugins
  install = { colorscheme = { 'habamax' } },
  -- Icons if nerd font
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

  -- Plugins to install
  spec = {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    -- To see what colorschemes are installed: `:Telescope colorscheme`.
    require 'plugins.colorscheme-kanagawa',
    require 'plugins.colorscheme-tokyonight',
    require 'plugins.colorscheme-nightfox',
    require 'plugins.colorscheme-onedark',
    require 'plugins.gitsigns',
    require 'plugins.flog',
    require 'plugins.which-key',
    require 'plugins.telescope',
    require 'plugins.neo-tree',
    require 'plugins.treesitter',
    require 'plugins.lspconfig',
    require 'plugins.cmp',
    require 'plugins.conform',
    require 'plugins.copilotchat',
    require 'plugins.todo-comments',
    require 'plugins.mini',
    require 'plugins.lualine',
    require 'plugins.crates',
    require 'plugins.oil',
    require 'plugins.dressing',
    require 'plugins.auto-session',
    require 'plugins.rooter',
    require 'plugins.jdtls',
    require 'plugins.neotest',
  },
}
