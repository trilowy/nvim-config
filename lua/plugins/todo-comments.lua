-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = false,
      keywords = {
        TODO = {
          alt = { 'todo!' },
        },
      },
      highlight = {
        pattern = [[(KEYWORDS)]],
        comments_only = false,
        keyword = 'bg',
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    },
  },
}
