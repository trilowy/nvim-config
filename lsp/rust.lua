-- Rust
-- https://github.com/rust-lang/rust-analyzer
return {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml', '.git' },
  filetypes = { 'rust' },
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
    },
  },
}
