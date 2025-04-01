-- Zig
-- https://github.com/zigtools/zls
return {
  cmd = { 'zls' },
  root_markers = { 'build.zig', '.git' },
  filetypes = { 'zig' },
  settings = {
    zls = {
      enable_build_on_save = true,
    },
  },
}
