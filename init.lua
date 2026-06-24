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
-- Schedule the setting after `UiEnter` because it can increase startup-time
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Show line number column
vim.opt.number = true
-- Relative line number
vim.opt.relativenumber = true

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

-- Diagnostics
vim.diagnostic.config {
  -- Show them inline
  virtual_text = true,
  -- Show them with underline and arrow like Rust compiler
  -- virtual_lines = true,
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
vim.o.winborder = 'rounded'

-- TODO: :h undofile
-- Save undo history even after closing the buffer or a crash

-- Recognize *.zt (Zig template) file as HTML
vim.filetype.add {
  extension = {
    zt = 'html',
  },
}

-- =============
-- || Plugins ||
-- =============

-- :checkhealth vim.pack
-- :lua vim.pack.update() will update all plugins
-- :lua vim.pack.update({ 'mini.nvim' })
-- :lua vim.pack.update(nil, { offline = true }) show the current state of plugins without downloading new changes from sources
-- :lua vim.pack.update(nil, { target = 'lockfile' }) make sure that plugin state on disk is the same as recorded in the lockfile
-- :lua vim.pack.del({ 'nvim-lspconfig', 'nvim-treesitter' }) delete plugin(s) from disk. This will also remove the plugin from the lockfile
-- After an update a confirmation buffer is shown with update details for the user to read, confirm (execute :write for that) or deny (close the window for that, like with :quit) the update

-- Faster start time
-- See https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
vim.loader.enable()

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    local plugin_path = ev.data.path

    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    -- Compiling telescope-fzf-native
    if name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = plugin_path }):wait()
      return
    end

    -- Updating tree-sitter parsers whenever the plugin is updated
    if name == 'nvim-treesitter' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
      return
    end

    -- Compiling LuaSnip
    if name == 'LuaSnip' then
      vim.system({ 'make', 'install_jsregexp' }, { cwd = plugin_path }):wait()
      return
    end
  end,
})

-- Colorscheme
vim.pack.add { 'https://github.com/rebelot/kanagawa.nvim' }

require('kanagawa').setup {
  colors = {
    palette = {
      -- See https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua for other color override
      sumiInk0 = '#0E0D18', -- Hover background
      sumiInk3 = '#0E0D18', -- Background
      sumiInk4 = '#151521', -- Darker foreground (line numbers, fold column, non-text characters), float borders
      sumiInk5 = '#222238', -- Current line
      waveBlue1 = '#334765', -- Popup background, visual selection background
      waveBlue2 = '#54546D', -- Popup selection
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
    -- See https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/themes.lua
    theme = {
      all = {
        ui = {
          pmenu = {
            bg = '#0E0D18',
          },
        },
      },
    },
  },
}

-- Neovim default habamax, slate, unokai, wildcharm and sorbet are also nice, maybe zellner for Java
vim.cmd.colorscheme 'kanagawa-wave'

-- TODO: other colorscheme?
-- Light colorscheme for work
-- vim.pack.add { 'https://github.com/navarasu/onedark.nvim' }

-- require('onedark').setup {
--   -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--   style = 'light',
-- }

-- Simple colorscheme to highlight what’s essential
-- vim.pack.add { 'https://github.com/p00f/alabaster.nvim' }

-- vim.pack.add { 'https://github.com/EdenEast/nightfox.nvim' } -- dawnfox as light colorscheme

-- require('nightfox').setup()

-- vim.pack.add { 'https://github.com/folke/tokyonight.nvim' }

-- Directory edition
vim.pack.add {
  'https://github.com/stevearc/oil.nvim',
  -- Dependencies
  'https://github.com/nvim-tree/nvim-web-devicons',
}

require('oil').setup {
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      -- Never show parent dir
      return (name == '..')
    end,
  },
}

-- Tree directory edition
vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '3.x' },
  -- Dependencies
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  -- 'https://github.com/nvim-tree/nvim-web-devicons', -- Duplicate
}

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
}

-- Automatically change root dir to the project of the current buffer
-- TODO: does not work with a git repo inside a another git repo (dotfiles for home) as it autoroot 2 times
-- vim.pack.add { 'https://github.com/notjedi/nvim-rooter.lua' }
--
-- require('nvim-rooter').setup()

-- Fuzzy search
vim.pack.add {
  { src = 'https://github.com/nvim-telescope/telescope.nvim', version = vim.version.range '0.2.x' },
  -- Dependencies
  -- 'https://github.com/nvim-lua/plenary.nvim', -- Duplicate
  -- 'https://github.com/nvim-tree/nvim-web-devicons', -- Duplicate
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/cljoly/telescope-repo.nvim',
}

require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
      },
      i = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
      },
    },
  },
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

-- Better popup for LSP rename
-- TODO: try to make it work with snacks.nvim
vim.pack.add { 'https://github.com/stevearc/dressing.nvim' }

require('dressing').setup()

-- Useful status updates for LSP
-- TODO: might not need it with statusline
-- vim.pack.add { 'https://github.com/j-hui/fidget.nvim' }

-- Navigate todos in comments
vim.pack.add {
  'https://github.com/folke/todo-comments.nvim',
  -- Dependencies
  -- 'https://github.com/nvim-lua/plenary.nvim', -- Duplicate
}

require('todo-comments').setup()

-- Show keymaps while typing them
vim.pack.add {
  'https://github.com/folke/which-key.nvim',
  -- Dependencies
  -- 'https://github.com/nvim-tree/nvim-web-devicons', -- Duplicate
}

require('which-key').setup()

-- Statusline
vim.pack.add {
  'https://github.com/nvim-lualine/lualine.nvim',
  -- Dependencies
  -- 'https://github.com/nvim-tree/nvim-web-devicons', -- Duplicate
}

require('lualine').setup {
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
}

-- Install syntax parsers for treesitter
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }

-- Ensure basic parsers are installed
local parsers = { 'lua', 'luadoc', 'markdown', 'markdown_inline' }
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(language) then
    return
  end
  -- Enable syntax highlighting and other treesitter features
  vim.treesitter.start(buf, language)

  -- Enable treesitter based folds
  -- For more info on folds see `:help folds`
  -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- vim.wo.foldmethod = 'expr'

  -- Check if treesitter indentation is available for this language, and if so enable it
  -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
  local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

  -- Enable treesitter based indentation
  if has_indent_query then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
      return
    end

    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed_parsers, language) then
      -- Enable the parser if it is already installed
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
      require('nvim-treesitter').install(language):await(function()
        treesitter_try_attach(buf, language)
      end)
    else
      -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
      treesitter_try_attach(buf, language)
    end
  end,
})

-- Snippet engine (used for Java header comment)
vim.pack.add { { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.x' } }

require('luasnip').setup()

-- Better autocompletion (LSP, snippets, path)
vim.pack.add { { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.x' } }

require('blink-cmp').setup {
  keymap = {
    ['<c-i>'] = { 'select_and_accept' },
    ['<c-l>'] = { 'snippet_forward', 'fallback' },
    ['<c-h>'] = { 'snippet_backward', 'fallback' },
    ['<c-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  snippets = { preset = 'luasnip' },
  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}

-- Auto-format on save
vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

require('conform').setup {
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettierd' },
    html = { 'prettierd' },
  },
}

-- TODO: Git
-- What I need:
-- - [x] Change branch (<leader>gb and <c-t> to track new remote branch)
-- - [x] Change to new branch (<leader>gb and <c-a> to create new branch)
-- - [x] Branch graph (<leader>gl)
-- - [x] Delete local branch (<leader>gb and <c-d> to delete branch)
-- - [x] Delete upstream branch (command line)
-- - [x] See all changes in workspace/index: with a 2 views (<leader>gg)
-- - [ ] Add only some chars to index
-- - [x] Pull (command line)
-- - [x] Fetch (command line)
-- - [x] Commit (command line)
-- - [x] Push (command line)
-- - [x] Push force-with-lease (command line)
-- - [ ] Squash
-- - [ ] Fixup
-- - [ ] Reword
-- - [x] Rebase onto another branch (<leader>gb and <c-r> to rebase)
-- - [ ] Rebase interactive
-- - [x] Merge a branch (<leader>gb and <c-y> to merge)
-- - [x] Conflict resolution (<leader>gg)
-- - [x] Git blame a file (<leader>gB)
-- - [x] Git blame: see what changed
-- - [x] History on a file (<leader>gf)
-- - [ ] Gitlab MR review?
-- - [ ] Create tag?
-- - [ ] Delete tag?
-- - [ ] Stash?

-- TODO: learn diff-mode
-- Familiarize Yourself With :h diff-mode
-- This plugin assumes you're familiar with all the features already provided by nvim's builtin diff-mode. These features include:
-- - Jumping between hunks (:h jumpto-diffs).
-- - Applying the changes of a diff hunk from any of the diffed buffers (:h copy-diffs).
-- For more information on the merge tool, mappings, layouts and how to configure them, see: :h diffview-merge-tool

-- TODO: learn fugitive/git command to amend a commit
-- https://github.com/tpope/vim-fugitive?tab=readme-ov-file#screencasts

-- Git integration
vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }

require('gitsigns').setup()

-- Git
vim.pack.add {
  'https://github.com/tpope/vim-fugitive',
  -- Fugitive Github integration
  'https://github.com/tpope/vim-rhubarb',
  -- Fugitive Gitlab integration
  'https://github.com/shumphrey/fugitive-gitlab.vim',
}

-- Git graph
-- TODO: to configure and learn
vim.pack.add {
  'https://github.com/rbong/vim-flog',
  -- Dependencies
  -- 'https://github.com/tpope/vim-fugitive', -- Duplicate
}

-- See Git changes and resolve conflicts
vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

local diffview_actions = require 'diffview.actions'
require('diffview').setup {
  view = {
    merge_tool = {
      layout = 'diff4_mixed',
    },
  },
  keymaps = {
    view = {
      { 'n', '<leader>Co', diffview_actions.conflict_choose 'ours', { desc = 'Choose the OURS version of a conflict' } },
      { 'n', '<leader>Ct', diffview_actions.conflict_choose 'theirs', { desc = 'Choose the THEIRS version of a conflict' } },
      { 'n', '<leader>Cb', diffview_actions.conflict_choose 'base', { desc = 'Choose the BASE version of a conflict' } },
      { 'n', '<leader>Ca', diffview_actions.conflict_choose 'all', { desc = 'Choose all the versions of a conflict' } },
      { 'n', '<leader>CO', diffview_actions.conflict_choose_all 'ours', { desc = 'Choose the OURS version of a conflict for the whole file' } },
      { 'n', '<leader>CT', diffview_actions.conflict_choose_all 'theirs', { desc = 'Choose the THEIRS version of a conflict for the whole file' } },
      { 'n', '<leader>CB', diffview_actions.conflict_choose_all 'base', { desc = 'Choose the BASE version of a conflict for the whole file' } },
      { 'n', '<leader>CA', diffview_actions.conflict_choose_all 'all', { desc = 'Choose all the versions of a conflict for the whole file' } },
    },
  },
}

-- Detect tabstop and shiftwidth automatically
vim.pack.add { 'https://github.com/tpope/vim-sleuth' }

-- Recover automatically the last session and opened buffers
-- TODO: to replace by https://github.com/olimorris/persisted.nvim to save by Git branch
vim.pack.add { 'https://github.com/rmagatti/auto-session' }

require('auto-session').setup()

-- Install LSP
vim.pack.add { 'https://github.com/mason-org/mason.nvim' }

-- Automatically install LSP
vim.pack.add { 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' }

-- Change case
vim.pack.add {
  { src = 'https://github.com/gregorias/coerce.nvim', version = vim.version.range '5.x' },
  -- Dependencies
  'https://github.com/gregorias/coop.nvim.git',
}

require('coerce').setup()
local coerce_which_key_keymaps = require('coerce.keymaps').which_key_expand

-- TODO: Buffer navigation
-- vim.pack.add { 'https://github.com/otavioschwanck/arrow.nvim' }
-- vim.pack.add { { src = 'https://github.com/ThePrimeagen/harpoon/tree/harpoon2', version = 'harpoon2' } }

-- TODO: Markdown preview https://github.com/OXY2DEV/markview.nvim

-- TODO: Copilot chat for work or https://github.com/olimorris/codecompanion.nvim

-- TODO: org-mode to take notes
-- - https://github.com/nvim-neorg/neorg (young and incomplete)
-- - https://github.com/nvim-orgmode/orgmode

-- Manage Rust crates
vim.pack.add {
  { src = 'https://github.com/saecki/crates.nvim', version = 'stable' },
  -- Dependencies
  -- LSP like for crates
  'https://github.com/nvimtools/none-ls.nvim',
  -- 'https://github.com/nvim-lua/plenary.nvim', -- Duplicate
}

require('crates').setup {
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
}

-- Java LSP
-- See ftplugin/java.lua for the whole configuration
vim.pack.add { 'https://github.com/mfussenegger/nvim-jdtls' }

-- =========
-- || LSP ||
-- =========

-- :checkhealth lsp

-- Automatically install following LSP with Mason
require('mason').setup()

require('mason-tool-installer').setup {
  ensure_installed = {
    -- LSP
    'jdtls', -- Java: started in ftplugin/java.lua
    -- 'html-lsp',
    -- 'kotlin-lsp',
    -- 'superhtml',
    -- 'tailwindcss-language-server',
    -- Formatter
    'prettierd',
  },
}

-- TODO: JS/TS with ts_ls?
-- TODO: superhtml crashes on small Zig zmpl templates without layout: Templated HTML (Jinja2, Angular, Mustache, ...) is not yet supported when all validation rules are enabled, use --syntax-only to limit validation to syntax errors to use SuperHTML with templated HTML documents.

-- With blink.cmp and luasnip, Neovim now has more capabilities, we broadcast that to the LSP
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('*', {
  capabilities = capabilities,
  root_markers = { '.git' },
})

vim.lsp.enable {
  'gleam',
  'lua',
  'rust',
  'toml',
  -- 'html',
  'kotlin',
  -- 'superhtml',
  -- 'tailwindcss',
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
    if client.server_capabilities.inlayHintProvider then
      vim.keymap.set('n', '<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
      end, { buffer = event.buf, desc = '[L]SP: toggle inlay [h]ints' })
    end

    -- Highlight references of the word under the cursor
    if client.server_capabilities.documentHighlightProvider then
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

-- Add Java header snippet
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local function year()
  return vim.fn.strftime '%Y'
end

ls.add_snippets('java', {
  s('header', {
    t { '/*', ' * -----------------------------------------------------------------', '' },
    t ' * Ce code source est la propriété de TODO. Tous droits réservés, ',
    f(year, {}),
    t '.',
    t {
      '',
      ' * (C) Copyright TODO, ',
    },
    f(year, {}),
    t {
      '',
      ' * -----------------------------------------------------------------',
      ' */',
    },
  }),
})

-- =============
-- || Keymaps ||
-- =============

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = '[w]rite buffer' })
vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>', { desc = '[c]lose buffer' })
-- %bd = delete all buffers.
-- e# = open the last buffer for editing.
-- bd# = delete the [No Name] buffer that gets created
-- '" = keep cursor position
vim.keymap.set('n', '<leader>d', '<cmd>%bd|e#|bd#<cr>|\'"', { desc = 'close all buffers except current one' })
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
  { '<leader>k', group = 'change case', mode = 'n', expand = coerce_which_key_keymaps.motion_mode },
  { '<leader>k', group = 'change case', mode = 'v', expand = coerce_which_key_keymaps.visual_mode },
}

local telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader>s.', telescope.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
vim.keymap.set('n', '<leader>sd', telescope.diagnostics, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>se', '<cmd>SessionSearch<cr>', { desc = '[s]earch s[e]ssion' })
vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = '[s]earch by [g]rep' })
vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sr', telescope.resume, { desc = '[s]earch [r]esume' })
vim.keymap.set('n', '<leader>sR', telescope.registers, { desc = '[s]earch [R]egisters' })
vim.keymap.set('n', '<leader>ss', telescope.builtin, { desc = '[s]earch [s]elect Telescope' })
vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = '[s]earch [t]odo' })
vim.keymap.set('n', '<leader>sw', telescope.grep_string, { desc = '[s]earch current [w]ord' })

vim.keymap.set('n', '<leader>gb', telescope.git_branches, { desc = '[g]it: [b]ranches' })
vim.keymap.set('n', '<leader>gB', '<cmd>:Gitsigns blame<cr>', { desc = '[g]it: [B]lame' })
-- TODO: close with <leader>c instead? maybe closing tab if more than one
vim.keymap.set('n', '<leader>gc', '<cmd>:DiffviewClose<cr>', { desc = '[g]it: [c]lose diff view' })
vim.keymap.set('n', '<leader>gf', '<cmd>:DiffviewFileHistory %<cr>', { desc = '[g]it: [f]ile commit history' })
vim.keymap.set('n', '<leader>gg', '<cmd>:DiffviewOpen<cr>', { desc = '[g]it: status or conflict resolution' })
vim.keymap.set('n', '<leader>gh', '<cmd>:DiffviewFileHistory<cr>', { desc = '[g]it: project commit [h]istory' })
vim.keymap.set('n', '<leader>gl', '<cmd>Flog -all<cr>', { desc = '[g]it: [l]og' })

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

vim.keymap.set('n', '<leader>sF', function()
  telescope.find_files {
    no_ignore = true, -- Include ignored files
    hidden = true, -- Optionally include hidden files
  }
end, { desc = '[s]earch all [F]iles' })

vim.keymap.set('n', '<leader>sG', function()
  telescope.live_grep {
    additional_args = function()
      return { '--no-ignore' }
    end,
  }
end, { desc = '[s]earch by [G]rep on all files' })

vim.keymap.set('v', '<leader>sg', "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<cr>", { desc = '[s]earch by [g]rep the selection' })

vim.keymap.set('v', 'gs', ':s/<bslash>(.*<bslash>)/<bslash><bslash><bslash><bslash><bslash>1<cr><cmd>nohlsearch<cr>', { desc = 'zig multiline string' })

vim.keymap.set('n', '\\', '<cmd>Neotree position=float reveal<cr>', { desc = 'NeoTree reveal' })

vim.keymap.set('n', '<leader>k', '<Plug>(coerce-motion)', { desc = 'change case for motion' })
vim.keymap.set('v', '<leader>k', '<Plug>(coerce-visual)', { desc = 'change case for selection' })

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
