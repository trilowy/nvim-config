-- Lua
-- https://github.com/luals/lua-language-server
-- Can be installed with zypper, stylua too
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.stylua.toml', '.git' },
  settings = {
    Lua = {
      -- Make the server aware of Neovim runtime files
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}
