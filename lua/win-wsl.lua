vim.g.clipboard = {
  name = 'WslClipboard',
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
