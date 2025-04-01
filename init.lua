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
-- || Options ||
-- =============

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Share clipboard between Windows and WSL
-- :h clipboard-wsl
if vim.fn.has 'wsl' == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = false,
  }
end

-- Sync clipboard between OS and Neovim
vim.opt.clipboard = 'unnamedplus'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Show line number column
vim.opt.number = true

-- Highlight cursor line
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Show sign column
vim.opt.signcolumn = 'yes'

-- Tab size
vim.opt.tabstop = 4

-- Every wrapped line will continue visually indented
vim.opt.breakindent = true

-- Case-insensitive searching unless \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions live at the bottom while typing
vim.opt.inccommand = 'split'

-- Where new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Colorscheme (slate, unokai, wildcharm and habamax are also nice, maybe zellner for Java)
vim.cmd.colorscheme 'sorbet'

-- Diagnostics
vim.diagnostic.config {
  -- Show them inline
  -- virtual_text = true,
  -- Show them with underline and arrow like Rust compiler
  virtual_lines = true,
}

-- TODO: style with colorscheme
vim.opt.winborder = 'rounded'

-- =============
-- || Plugins ||
-- =============

require('lazy').setup {
  -- Colorscheme that will be used when installing plugins
  install = { colorscheme = { 'sorbet' } },
  -- Automatically check for plugin updates
  checker = { enabled = true },

  -- Plugins to install
  spec = {
    {
      -- Directory edition
      -- https://github.com/stevearc/oil.nvim
      'stevearc/oil.nvim',
      dependencies = { { 'echasnovski/mini.icons', opts = {} } },
      opts = {
        view_options = {
          show_hidden = true,
        },
      },
    },
    -- TODO: add plugins
    -- TODO: need format on save
    -- TODO: need Telescope
  },
}

-- =========
-- || LSP ||
-- =========

-- :checkhealth lsp

-- TODO: Lua
-- TODO: Java
-- TODO: TailwindCSS
-- TODO: JS/TS?
-- TODO: Zig

-- Rust
vim.lsp.config.rust_analyzer = {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml' },
  filetypes = { 'rust' },
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}

vim.lsp.enable { 'rust_analyzer' }

-- LSP auto-completion
-- FIXME: autotrigger typing full word is not OK https://neovim.io/doc/user/lsp.html
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method 'textDocument/completion' then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- =============
-- || Keymaps ||
-- =============

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[w]rite buffer' })
vim.keymap.set('n', '<leader>c', '<cmd>bd<CR>', { desc = '[c]lose buffer' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlight on search' })
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
