-- Navigate todos in comments
-- https://github.com/folke/todo-comments.nvim
return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false,
    -- -- Options to search also in the code for Rust todo! macro
    -- keywords = {
    --   TODO = {
    --     alt = { 'todo!' },
    --   },
    -- },
    -- highlight = {
    --   pattern = [[(KEYWORDS)]],
    --   comments_only = false,
    --   keyword = 'bg',
    -- },
    -- search = {
    --   pattern = [[\b(KEYWORDS)\b]],
    -- },
  },
}
