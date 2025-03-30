require 'options'
require 'keymaps'
require 'lazy-plugins'

if vim.fn.has 'wsl' == 1 then
  require 'win-wsl'
end
