-- Lua
-- https://github.com/luals/lua-language-server
-- Can be installed with zypper, stylua too
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.stylua.toml', '.git' },
  -- TODO: see if needed
  -- settings = {
  --   Lua = {
  --     completion = {
  --       callSnippet = 'Replace',
  --     },
  --   },
  -- },
}
