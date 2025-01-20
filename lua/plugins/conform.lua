-- Zig organize imports on save
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = { '*.zig', '*.zon' },
--   callback = function(ev)
--     vim.lsp.buf.code_action {
--       context = { only = { 'source.organizeImports' } },
--       apply = true,
--     }
--   end,
-- })

-- Autoformat
return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[f]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = {
        c = true,
        cpp = true,
        -- Disable autoformat for zmpl
        html = true,
      }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { { 'prettierd', 'prettier' } },
    },
  },
}
