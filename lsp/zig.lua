-- Zig
-- https://github.com/zigtools/zls
return {
  cmd = { 'zls' },
  filetypes = { 'zig' },
  root_markers = { 'build.zig', '.git' },
  settings = {
    zls = {
      enable_build_on_save = true,
    },
  },
}
