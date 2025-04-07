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
      -- Windows clip.exe uses UTF-16LE encoding but Neovim only uses UTF-8, we need to convert to copy/paste special characters correctly
      ['+'] = { 'sh', '-c', 'iconv -f UTF-8 -t UTF-16LE | clip.exe' },
      ['*'] = { 'sh', '-c', 'iconv -f UTF-8 -t UTF-16LE | clip.exe' },
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

-- If a nerd font (with icons) is installed
vim.g.have_nerd_font = true

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

-- Enable mouse in all modes (for resizing splits)
vim.opt.mouse = 'a'

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Open a menu for auto-completion, even if there is only one choice but do not insert if not accepted
vim.o.completeopt = 'menu,menuone,noinsert,popup'

-- Decrease update time for LSP highlight of references
vim.opt.updatetime = 500

-- Decrease mapped sequence wait time to display which-key popup sooner
vim.opt.timeoutlen = 300

-- For auto save/restore of sessions
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
