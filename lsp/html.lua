-- HTML
-- https://github.com/hrsh7th/vscode-langservers-extracted
-- Can be installed with: npm i -g scode-langservers-extracted
return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  settings = {
    format = {
      enable = true,
    },
  },
}
