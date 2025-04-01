-- TailwindCSS
-- https://github.com/tailwindlabs/tailwindcss-intellisense
-- Can be installed with: npm install -g @tailwindcss/language-server
return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = { 'html', 'css', 'rust' },
  root_markers = { 'tailwind.config.js' },
  init_options = {
    userLanguages = {
      -- To complete in HTML inside Rust macro in *.rs files
      rust = 'html',
    },
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      classAttributes = { 'class' },
    },
  },
}
