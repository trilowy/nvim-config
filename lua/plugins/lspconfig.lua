return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSP
    { 'folke/lazydev.nvim', ft = 'lua', opts = {} }, -- Neovim config LSP
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
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
        vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = '[L]SP: [s]ignature help' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Inlay hints
        if client and client.supports_method 'inlayHint/resolve' and vim.lsp.inlay_hint then
          vim.keymap.set('n', '<leader>lh', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
          end, { buffer = event.buf, desc = '[L]SP: toggle inlay [h]ints' })
        end

        -- Highlight references of the word under the cursor
        if client and client.supports_method 'textDocument/documentHighlight' then
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
      end,
    })

    -- Broadcast nvim-cmp client additional capabilities to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      taplo = {},
      tailwindcss = {
        filetypes = { 'html', 'css', 'rust' },
        init_options = {
          userLanguages = {
            rust = 'html',
          },
        },
      },
      -- htmx = {},
      -- ts_ls = {},
      svelte = {},
      html = {
        settings = {
          format = {
            enable = true,
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
      -- Java LSP configured in nvim-jdtls plugin
      jdtls = { autostart = false },
    }

    local external_servers = {
      zls = {
        settings = {
          zls = {
            enable_build_on_save = true,
          },
        },
      },
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      },
      gleam = {},
      -- FIXME: superhtml crashes on small templates without layout
      -- superhtml = {
      --   filetypes = { 'html', 'zmpl' },
      -- },
      metals = {},
    }

    -- zls: don't show parse errors in a separate window
    vim.g.zig_fmt_parse_errors = 0

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    -- Other tools to install with Mason
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Configure LSP installed with Mason
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server_config = servers[server_name] or {}
          server_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_config.capabilities or {})
          require('lspconfig')[server_name].setup(server_config)
        end,
      },
    }

    -- Configure LSP not installed with Mason
    for server_name, server_config in pairs(external_servers) do
      server_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_config.capabilities or {})
      require('lspconfig')[server_name].setup(server_config)
    end
  end,
}
