-- Git graph
-- https://github.com/rbong/vim-flog
-- TODO: to configure
return {
  'rbong/vim-flog',
  lazy = true,
  cmd = { 'Flog', 'Flogsplit', 'Floggit' },
  dependencies = {
    'tpope/vim-fugitive',
  },
}
