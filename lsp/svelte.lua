-- Svelte
-- https://github.com/sveltejs/language-tools
return {
  cmd = { 'svelteserver', '--stdio' },
  filetypes = { 'svelte' },
  root_markers = { 'package-lock.json', '.git' },
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = {
          enabled = 'literals',
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
  -- on_attach = function(client, _)
  --   if client.name == 'svelte' then
  --     vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  --       pattern = { '*.js', '*.ts' },
  --       callback = function(ctx)
  --         client:notify('$/onDidChangeTsOrJsFile', {
  --           uri = ctx.match,
  --         })
  --       end,
  --     })
  --   end
  -- end,
}
