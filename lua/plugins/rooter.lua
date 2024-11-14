-- Automatically change root dir to the project of the current buffer
return {
  {
    'notjedi/nvim-rooter.lua',
    config = function()
      require('nvim-rooter').setup()
    end,
  },
}
