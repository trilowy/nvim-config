-- TOML
-- https://github.com/tamasfe/taplo
-- Can be installed with: cargo install --features lsp --locked taplo-cli
return {
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
}
