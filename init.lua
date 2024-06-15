require 'options'
require 'keymaps'
require 'lazy-plugins'

if vim.fn.has 'windows' == 1 and vim.fn.has 'linux' == 1 then
  require 'win-wsl'
end
