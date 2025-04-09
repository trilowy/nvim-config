-- Manage Rust crates
-- https://github.com/saecki/crates.nvim
return {
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
    },
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  },
}
