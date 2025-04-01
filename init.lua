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
    -- Windows clip.exe uses UTF-16LE encoding but Neovim only uses UTF-8, we need to convert to copy/paste special characters correctly
    copy = {
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

-- Colorscheme (slate, unokai, wildcharm and sorbet are also nice, maybe zellner for Java)
vim.cmd.colorscheme 'habamax'

-- Diagnostics
vim.diagnostic.config {
  -- Show them inline
  -- virtual_text = true,
  -- Show them with underline and arrow like Rust compiler
  virtual_lines = true,
}

-- Open a menu for auto-completion, even if there is only one choice but do not insert if not accepted
vim.o.completeopt = 'menu,menuone,noinsert,popup,fuzzy'

-- Decrease update time for LSP highlight of references
vim.opt.updatetime = 500

-- Decrease mapped sequence wait time to display which-key popup sooner
vim.opt.timeoutlen = 300

-- For auto save/restore of sessions with auto-session
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Defines the default border style of floating windows. The default value
-- is empty, which is equivalent to "none". Valid values include:
-- - "none": No border.
-- - "single": A single line box.
-- - "double": A double line box.
-- - "rounded": Like "single", but with rounded corners ("╭" etc.).
-- - "solid": Adds padding by a single whitespace cell.
-- - "shadow": A drop shadow effect by blending with the background.
-- It is set to none and overriden later for the LSP because of Telescope bug
-- TODO: See https://github.com/nvim-telescope/telescope.nvim/issues/3436
vim.o.winborder = 'none'

-- TODO: :h undofile
-- Save undo history even after closing the buffer or a crash

-- =============
-- || Plugins ||
-- =============

require('lazy').setup {
  -- Colorscheme that will be used when installing plugins
  install = { colorscheme = { 'habamax' } },

  -- Plugins to install
  spec = {
    -- Colorscheme
    -- https://github.com/rebelot/kanagawa.nvim
    {
      'rebelot/kanagawa.nvim',
      priority = 1000,
      init = function()
        vim.cmd.colorscheme 'kanagawa-wave'
      end,
      opts = {
        colors = {
          palette = {
            -- See https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua for other color override
            sumiInk0 = '#0E0D18', -- Hover background
            sumiInk3 = '#0E0D18', -- Background
            sumiInk4 = '#151521', -- Darker foreground (line numbers, fold column, non-text characters), float borders
            sumiInk5 = '#222238', -- Current line
            waveBlue1 = '#334765', -- Popup background, visual selection background
            waveBlue2 = '#AD4D2D', -- Popup selection
            springGreen = '#42C492', -- String

            -- kanagawa-lotus
            lotusViolet4 = '#A626A4', -- pub fn let
            lotusBlue4 = '#4078F2', -- Function name
            lotusYellow = '#986801', -- Function var
            lotusWhite3 = '#FBFCFE', -- Background
            lotusWhite4 = '#EAECF3', -- Left background
            lotusWhite5 = '#EAECF3', -- Line highlight
            lotusAqua = '#3DA57D', -- Type
            lotusInk1 = '#1E1E1E', -- Text
            lotusYellow2 = '#986801', -- Pipe operator
          },
        },
      },
    },

    -- Light colorscheme for work
    -- https://github.com/navarasu/onedark.nvim
    {
      'navarasu/onedark.nvim',
      opts = {
        -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        style = 'light',
      },
    },

    -- TODO: other colorscheme?
    -- https://github.com/EdenEast/nightfox.nvim
    -- 'EdenEast/nightfox.nvim',
    -- https://github.com/folke/tokyonight.nvim
    -- 'folke/tokyonight.nvim',

    -- Directory edition
    -- https://github.com/stevearc/oil.nvim
    {
      'stevearc/oil.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      lazy = false,
      opts = {
        view_options = {
          show_hidden = true,
        },
      },
    },

    -- Tree directory edition
    -- https://github.com/nvim-neo-tree/neo-tree.nvim
    -- TODO: see if needed
    -- {
    --   'nvim-neo-tree/neo-tree.nvim',
    --   branch = 'v3.x',
    --   dependencies = {
    --     'nvim-lua/plenary.nvim',
    --     'nvim-tree/nvim-web-devicons',
    --     'MunifTanjim/nui.nvim',
    --   },
    --   cmd = 'Neotree',
    --   keys = {
    --     { '\\', ':Neotree position=float reveal<cr>', { desc = 'NeoTree reveal' } },
    --   },
    --   opts = {
    --     filesystem = {
    --       window = {
    --         mappings = {
    --           ['\\'] = 'close_window',
    --         },
    --       },
    --     },
    --   },
    -- },

    -- Automatically change root dir to the project of the current buffer
    -- https://github.com/notjedi/nvim-rooter.lua
    { 'notjedi/nvim-rooter.lua', opts = {} },

    -- Fuzzy search
    -- https://github.com/nvim-telescope/telescope.nvim
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
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
    },

    -- Better popup for LSP rename
    -- https://github.com/stevearc/dressing.nvim
    -- TODO: try to make it work with snacks.nvim
    { 'stevearc/dressing.nvim', opts = {} },

    -- Useful status updates for LSP
    -- https://github.com/j-hui/fidget.nvim
    -- TODO: might not need it with statusline
    -- { 'j-hui/fidget.nvim', opts = {} },

    -- Navigate todos in comments
    -- https://github.com/folke/todo-comments.nvim
    {
      'folke/todo-comments.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = {},
    },

    -- Show keymaps while typing them
    -- https://github.com/folke/which-key.nvim
    {
      'folke/which-key.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      event = 'VeryLazy',
      opts = {},
    },

    -- Statusline
    -- https://github.com/nvim-lualine/lualine.nvim
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
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
              ignore_lsp = { 'null-ls', 'crates.nvim' },
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
    },

    -- Better code highlight
    -- https://github.com/nvim-treesitter/nvim-treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      opts = {
        ensure_installed = { 'html', 'lua', 'luadoc', 'markdown', 'rust' },
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        highlight = { enable = true },
      },
      config = function(_, opts)
        -- Prefer git instead of curl in order to improve connectivity in some environments (use git proxy)
        require('nvim-treesitter.install').prefer_git = true
        require('nvim-treesitter.configs').setup(opts)
      end,
    },

    -- Neovim config LSP
    -- https://github.com/folke/lazydev.nvim
    { 'folke/lazydev.nvim', ft = 'lua', opts = {} },

    -- Better autocompletion (LSP, snippets, path)
    -- https://cmp.saghen.dev/
    {
      'saghen/blink.cmp',
      dependencies = {
        -- Snippet engine (used for Java header comment)
        -- https://github.com/L3MON4D3/LuaSnip for Java
        {
          'L3MON4D3/LuaSnip',
          version = 'v2.*',
          build = 'make install_jsregexp',
          opts = {},
        },
      },
      version = '1.*',
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = {
          ['<c-i>'] = { 'select_and_accept' },
          ['<c-l>'] = { 'snippet_forward', 'fallback' },
          ['<c-h>'] = { 'snippet_backward', 'fallback' },
          ['<c-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        completion = { documentation = { auto_show = true } },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
          providers = {
            lazydev = {
              name = 'LazyDev',
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
          },
        },
        snippets = { preset = 'luasnip' },
        -- Shows a signature help window while you type arguments for a function
        signature = { enabled = true },
      },
    },

    -- Auto-format on save
    -- https://github.com/stevearc/conform.nvim
    {
      'stevearc/conform.nvim',
      lazy = false,
      opts = {
        format_on_save = {
          timeout_ms = 500,
          lsp_format = 'fallback',
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = {
            stop_after_first = true,
            formatters = { 'prettierd', 'prettier' },
          },
        },
      },
    },

    -- Git integration
    -- https://github.com/lewis6991/gitsigns.nvim
    -- TODO: redo keymap with help of documentation
    -- What I need:
    -- - [ ] Change branch
    -- - [ ] Change to new branch
    -- - [ ] Branch graph
    -- - [ ] Delete local branch
    -- - [ ] Delete upstream branch
    -- - [ ] See all changes in workspace/index: with a 2 views
    -- - [ ] Add only some chars to index
    -- - [ ] Pull
    -- - [ ] Fetch
    -- - [ ] Commit
    -- - [ ] Push
    -- - [ ] Push force-with-lease
    -- - [ ] Stash
    -- - [ ] Squash
    -- - [ ] Fixup
    -- - [ ] Reword
    -- - [ ] Rebase onto another branch
    -- - [ ] Rebase interactive
    -- - [ ] Merge a branch
    -- - [ ] Conflict resolution: maybe 3 views instead of 2
    -- - [x] Git blame a file (<leader>gB)
    -- - [ ] Git blame: see what changed
    -- - [ ] History on a file
    -- - [ ] Gitlab MR review?
    -- - [ ] Create tag?
    -- - [ ] Delete tag?
    {
      'lewis6991/gitsigns.nvim',
      opts = {
        on_attach = function(bufnr)
          local gitsigns = require 'gitsigns'

          vim.keymap.set('n', ']g', function()
            if vim.wo.diff then
              vim.cmd.normal { ']g', bang = true }
            else
              gitsigns.nav_hunk 'next'
            end
          end, { buffer = bufnr, desc = '[g]it: next hunk' })

          vim.keymap.set('n', '[g', function()
            if vim.wo.diff then
              vim.cmd.normal { '[g', bang = true }
            else
              gitsigns.nav_hunk 'prev'
            end
          end, { buffer = bufnr, desc = '[g]it: previous hunk' })

          vim.keymap.set('n', '<leader>ga', gitsigns.stage_hunk, { buffer = bufnr, desc = '[g]it: [a]dd hunk (stage)' })
          vim.keymap.set('v', '<leader>ga', function()
            gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { buffer = bufnr, desc = '[g]it: [a]dd hunk (stage)' })
          vim.keymap.set('n', '<leader>gA', gitsigns.stage_buffer, { buffer = bufnr, desc = '[g]it: [A]dd buffer (stage)' })

          vim.keymap.set('n', '<leader>gB', gitsigns.blame, { buffer = bufnr, desc = '[g]it: [B]lame' })

          vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { buffer = bufnr, desc = '[g]it: [d]iff against index' })
          vim.keymap.set('n', '<leader>gD', function()
            gitsigns.diffthis '@'
          end, { buffer = bufnr, desc = '[g]it: [D]iff against last commit' })

          vim.keymap.set('n', '<leader>ge', gitsigns.preview_hunk_inline, { buffer = bufnr, desc = '[g]it: toggle git show d[e]leted' })
          vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { buffer = bufnr, desc = '[g]it: [p]review hunk' })

          vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { buffer = bufnr, desc = '[g]it: [r]eset hunk' })
          vim.keymap.set('v', '<leader>gr', function()
            gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { buffer = bufnr, desc = '[g]it: [r]eset hunk' })
          vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { buffer = bufnr, desc = '[g]it: [R]eset buffer' })

          vim.keymap.set('n', '<leader>gT', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = '[g]it: [T]oggle show blame line' })
        end,
      },
    },

    -- TODO: Git
    -- Fugitive:
    -- - https://github.com/tpope/vim-fugitive
    -- - https://www.reddit.com/r/neovim/comments/1h8aekd/vimfugitive_is_just_a_superior_way_to_manage_your/
    -- - Conflicts: https://www.youtube.com/watch?v=vpwJ7fqD1CE
    -- - https://www.reddit.com/r/neovim/comments/1h8aekd/comment/m13ry0k/
    --   - cF fixup commit
    --   - dv over the file which just shows native neovim diff over 2 files
    -- DiffView:
    -- - https://github.com/sindrets/diffview.nvim
    -- - Example: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/plugins/diffview.lua
    -- - https://www.reddit.com/r/neovim/comments/16xa2q0/what_is_the_best_git_diff_and_merge_tool/
    -- LazyGit:
    -- - https://github.com/folke/snacks.nvim/blob/main/docs%2Flazygit.md
    -- NeoGit:
    -- - https://github.com/NeogitOrg/neogit
    -- Gitlab MR: https://docs.gitlab.com/editor_extensions/neovim/

    -- Git graph
    -- https://github.com/rbong/vim-flog
    -- TODO: to configure
    {
      'rbong/vim-flog',
      lazy = true,
      cmd = { 'Flog', 'Flogsplit', 'Floggit' },
      dependencies = {
        'tpope/vim-fugitive',
      },
    },

    -- TODO: Compare 2 files (not necessarly git changes)
    -- :diffthis on 2 windows
    -- Better diffview

    -- Detect tabstop and shiftwidth automatically
    -- https://github.com/tpope/vim-sleuth
    'tpope/vim-sleuth',

    -- Recover automatically the last session and opened buffers
    -- https://github.com/rmagatti/auto-session
    -- TODO: to replace by https://github.com/olimorris/persisted.nvim to save by Git branch
    {
      'rmagatti/auto-session',
      lazy = false,
      keys = {
        { '<leader>se', '<cmd>SessionSearch<cr>', desc = '[s]earch s[e]ssion' },
      },
      ---@module "auto-session"
      ---@type AutoSession.Config
      opts = {},
    },

    -- Install LSP
    -- https://github.com/williamboman/mason.nvim
    { 'williamboman/mason.nvim', opts = {} },

    -- Automatically install LSP
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- TODO: Better substitute https://github.com/tpope/vim-abolish

    -- TODO: Buffer navigation
    -- https://github.com/otavioschwanck/arrow.nvim
    -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2 (branch harpoon2)

    -- TODO: camelCase to snake_case

    -- TODO: Markdown preview https://github.com/OXY2DEV/markview.nvim

    -- TODO: Copilot chat for work or https://github.com/olimorris/codecompanion.nvim

    -- Manage Rust crates
    -- https://github.com/saecki/crates.nvim
    {
      'saecki/crates.nvim',
      tag = 'stable',
      event = { 'BufRead Cargo.toml' },
      dependencies = {
        -- LSP like for crates
        'nvimtools/none-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
      },
      opts = {
        null_ls = {
          enabled = true,
          name = 'crates.nvim',
        },
        lsp = {
          enabled = true,
          -- TODO: capabilities?
          -- on_attach = function(client, bufnr)
          --   -- the same on_attach function as for your other lsp's
          -- end,
          actions = true,
          completion = true,
          hover = true,
        },
        -- TODO: needed? features?
        -- Dependencies completed from searches on crates.io
        -- completion = {
        --   crates = {
        --     enabled = true,
        --     max_results = 8,
        --     min_chars = 3,
        --   },
        -- },
      },
    },

    -- Java LSP
    -- https://github.com/mfussenegger/nvim-jdtls
    -- See ftplugin/java.lua for the whole configuration
    {
      'mfussenegger/nvim-jdtls',
      ft = 'java',
    },
  },
}

-- =========
-- || LSP ||
-- =========

-- :checkhealth lsp

-- Automatically install following LSP with Mason
require('mason-tool-installer').setup {
  ensure_installed = {
    -- LSP
    'lua-language-server',
    'jdtls', -- Java: started in ftplugin/java.lua
    'taplo', -- TOML
    'html-lsp',
    'tailwindcss-language-server',
    -- Formatter
    'stylua',
  },
}

-- TODO: see if I install with the OS instead of Mason the LSP I can
-- TODO: JS/TS with ts_ls?
-- TODO: superhtml crashes on small Zig zmpl templates without layout

-- With blink.cmp and luasnip, Neovim now has more capabilities, we broadcast that to the LSP
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('*', {
  capabilities = capabilities,
  root_markers = { '.git' },
})

vim.lsp.enable {
  -- 'gleam',
  'lua',
  'rust',
  'toml',
  'html',
  'tailwindcss',
  'zig',
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', {}),
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    -- Auto-completion
    -- TODO: autocompletion replaced by blink?
    -- TODO: see if we can add snippet and path, maybe text or crates https://github.com/Saecki/crates.nvim/wiki/Documentation-v0.6.0#auto-completion
    -- TODO: `<C-x><C-f>` in insert mode, autocompletion of file path
    -- if client.supports_method 'textDocument/completion' then
    --   -- Trigger autocompletion on every keypress
    --   local chars = {}
    --   for i = 32, 126 do
    --     table.insert(chars, string.char(i))
    --   end
    --   client.server_capabilities.completionProvider.triggerCharacters = chars
    --
    --   vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    -- end

    -- Auto-format on save
    -- TODO: format on save replaced by conform?
    -- if client.supports_method 'textDocument/formatting' then
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
    --     buffer = event.buf,
    --     callback = function()
    --       vim.lsp.buf.format { bufnr = event.buf, id = client.id, timeout_ms = 1000 }
    --     end,
    --   })
    -- end

    -- Inlay hints
    if client.supports_method 'inlayHint/resolve' then
      vim.keymap.set('n', '<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
      end, { buffer = event.buf, desc = '[L]SP: toggle inlay [h]ints' })
    end

    -- Highlight references of the word under the cursor
    if client.supports_method 'textDocument/documentHighlight' then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    local telescope = require 'telescope.builtin'
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, { buffer = event.buf, desc = 'LSP: [g]oto [d]efinition' })
    vim.keymap.set('n', 'gr', telescope.lsp_references, { buffer = event.buf, desc = 'LSP: [g]oto [r]eferences' })
    vim.keymap.set('n', 'gI', telescope.lsp_implementations, { buffer = event.buf, desc = 'LSP: [g]oto [I]mplementation' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = event.buf, desc = 'LSP: [g]oto [D]eclaration' })
    vim.keymap.set('n', 'gy', telescope.lsp_type_definitions, { buffer = event.buf, desc = 'LSP: [g]oto t[y]pe definition' })
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = event.buf, desc = '[L]SP: code [a]ctions' })
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = event.buf, desc = '[L]SP: [r]ename' })
    vim.keymap.set('n', '<leader>ls', telescope.lsp_document_symbols, { buffer = event.buf, desc = '[L]SP: document [s]ymbols' })
    vim.keymap.set('n', '<leader>lS', telescope.lsp_dynamic_workspace_symbols, { buffer = event.buf, desc = '[L]SP: workspace [S]ymbols' })
    -- TODO: autocompletion replaced by blink?
    -- vim.keymap.set('i', '<c-s>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = '[L]SP: [s]ignature help' })
  end,
})

-- =============
-- || Keymaps ||
-- =============

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = '[w]rite buffer' })
vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>', { desc = '[c]lose buffer' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'next [q]uickfix' })
vim.keymap.set('n', '[q', '<cmd>cprev<cr>', { desc = 'previous [q]uickfix' })
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'clear highlight on search' })
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'open parent directory' })
-- TODO: autocompletion replaced by blink?
-- vim.keymap.set('i', '<tab>', '<c-y>', { noremap = true, desc = 'accept ([i]nsert) the completion (for some reason <c-i> = <tab>)' })
--
-- vim.keymap.set({ 'i', 's' }, '<c-l>', function()
--   if vim.snippet.active { direction = 1 } then
--     return '<cmd>lua vim.snippet.jump(1)<cr>'
--   end
-- end, { expr = true, desc = 'next snippet value (because <tab> is already remapped)' })
--
-- vim.keymap.set({ 'i', 's' }, '<c-h>', function()
--   if vim.snippet.active { direction = -1 } then
--     return '<cmd>lua vim.snippet.jump(-1)<cr>'
--   end
-- end, { expr = true, desc = 'previous snippet value' })
--
-- vim.keymap.set('i', '<c-space>', function()
--   vim.lsp.completion.get()
-- end, { desc = 'trigger auto-completion' })

-- Fix LSP hover popup
-- TODO: See https://github.com/nvim-telescope/telescope.nvim/issues/3436#issuecomment-2775658101
local lsp_hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return lsp_hover { border = 'rounded' }
end

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'next [t]odo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'previous [t]odo comment' })

require('which-key').add {
  { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
  { '<leader>l', group = '[L]SP', mode = { 'n', 'v' } },
  { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
  { '<leader>r', group = '[R]ust crates', mode = { 'n', 'v' } },
  { '<leader>j', group = '[J]ava', mode = { 'n', 'v' } },
}

local telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader>s.', telescope.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
vim.keymap.set('n', '<leader>sd', telescope.diagnostics, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = '[s]earch by [g]rep' })
vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sr', telescope.resume, { desc = '[s]earch [r]esume' })
vim.keymap.set('n', '<leader>sR', telescope.registers, { desc = '[s]earch [R]egisters' })
vim.keymap.set('n', '<leader>ss', telescope.builtin, { desc = '[s]earch [s]elect Telescope' })
vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = '[s]earch [t]odo' })
vim.keymap.set('n', '<leader>sw', telescope.grep_string, { desc = '[s]earch current [w]ord' })

-- TODO: Git workflow to do
vim.keymap.set('n', '<leader>gb', telescope.git_branches, { desc = '[g]it: [b]ranches' })
vim.keymap.set('n', '<leader>gf', telescope.git_bcommits, { desc = '[g]it: [f]ile commit history' })
vim.keymap.set('n', '<leader>gg', '<cmd>Flog -all<cr>', { desc = '[g]it: [g]raph' })
vim.keymap.set('n', '<leader>gh', telescope.git_commits, { desc = '[g]it: project commit [h]istory' })
vim.keymap.set('n', '<leader>gs', telescope.git_stash, { desc = '[g]it: [s]tashes' })
vim.keymap.set('n', '<leader>gt', telescope.git_status, { desc = '[g]it: s[t]atus' })

vim.keymap.set('n', '<leader>sp', function()
  require('telescope').extensions.repo.list { search_dirs = { '~/workspace' } }
end, { desc = '[s]earch in workspace [p]rojects' })

vim.keymap.set('n', '<leader><leader>', function()
  telescope.buffers {
    sort_mru = true,
    ignore_current_buffer = true,
  }
end, { desc = 'find existing buffers' })

vim.keymap.set('n', '<leader>/', function()
  telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sc', function()
  telescope.colorscheme {
    enable_preview = true,
  }
end, { desc = '[s]earch [c]olor scheme' })

vim.keymap.set('v', '<leader>sg', "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<cr>", { desc = '[s]earch by [g]rep the selection' })

local crates = require 'crates'
vim.keymap.set('n', '<leader>rt', crates.toggle, { desc = '[r]ust crates: [t]oggle' })
vim.keymap.set('n', '<leader>rr', crates.reload, { desc = '[r]ust crates: [r]eload' })
vim.keymap.set('n', '<leader>rv', crates.show_versions_popup, { desc = '[r]ust crates: show [v]ersions' })
vim.keymap.set('n', '<leader>rf', crates.show_features_popup, { desc = '[r]ust crates: show [f]eatures' })
vim.keymap.set('n', '<leader>rd', crates.show_dependencies_popup, { desc = '[r]ust crates: show [d]ependencies' })
vim.keymap.set('n', '<leader>ru', crates.update_crate, { desc = '[r]ust crates: [u]pdate' })
vim.keymap.set('v', '<leader>ru', crates.update_crates, { desc = '[r]ust crates: [u]pdate' })
vim.keymap.set('n', '<leader>rU', crates.upgrade_crate, { desc = '[r]ust crates: [U]pgrade' })
vim.keymap.set('v', '<leader>rU', crates.upgrade_crates, { desc = '[r]ust crates: [U]pgrade' })
vim.keymap.set('n', '<leader>rA', crates.upgrade_all_crates, { desc = '[r]ust crates: upgrade [A]ll crates' })
vim.keymap.set('n', '<leader>rx', crates.expand_plain_crate_to_inline_table, { desc = '[r]ust crates: e[x]pand to inline table' })
vim.keymap.set('n', '<leader>rX', crates.extract_crate_into_table, { desc = '[r]ust crates: e[X]tract into table' })
vim.keymap.set('n', '<leader>rH', crates.open_homepage, { desc = '[r]ust crates: [H]omepage' })
vim.keymap.set('n', '<leader>rR', crates.open_repository, { desc = '[r]ust crates: [R]epository' })
vim.keymap.set('n', '<leader>rD', crates.open_documentation, { desc = '[r]ust crates: [D]ocumentation' })
vim.keymap.set('n', '<leader>rC', crates.open_crates_io, { desc = '[r]ust crates: open [C]rates.io' })
