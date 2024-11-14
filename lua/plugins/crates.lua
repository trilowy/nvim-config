return {
  'saecki/crates.nvim',
  tag = 'stable',
  event = { 'BufRead Cargo.toml' },
  config = function()
    local crates = require 'crates'
    crates.setup {
      null_ls = {
        enabled = true,
      },
    }

    vim.keymap.set('n', '<leader>rt', crates.toggle, { silent = true, desc = '[r]ust crates: [t]oggle' })
    vim.keymap.set('n', '<leader>rr', crates.reload, { silent = true, desc = '[r]ust crates: [r]eload' })

    vim.keymap.set('n', '<leader>rv', crates.show_versions_popup, { silent = true, desc = '[r]ust crates: show [v]ersions' })
    vim.keymap.set('n', '<leader>rf', crates.show_features_popup, { silent = true, desc = '[r]ust crates: show [f]eatures' })
    vim.keymap.set('n', '<leader>rd', crates.show_dependencies_popup, { silent = true, desc = '[r]ust crates: show [d]ependencies' })

    vim.keymap.set('n', '<leader>ru', crates.update_crate, { silent = true, desc = '[r]ust crates: [u]pdate' })
    vim.keymap.set('v', '<leader>ru', crates.update_crates, { silent = true, desc = '[r]ust crates: [u]pdate' })
    vim.keymap.set('n', '<leader>rU', crates.upgrade_crate, { silent = true, desc = '[r]ust crates: [U]pgrade' })
    vim.keymap.set('v', '<leader>rU', crates.upgrade_crates, { silent = true, desc = '[r]ust crates: [U]pgrade' })
    vim.keymap.set('n', '<leader>rA', crates.upgrade_all_crates, { silent = true, desc = '[r]ust crates: upgrade [A]ll crates' })

    vim.keymap.set('n', '<leader>rx', crates.expand_plain_crate_to_inline_table, { silent = true, desc = '[r]ust crates: e[x]pand to inline table' })
    vim.keymap.set('n', '<leader>rX', crates.extract_crate_into_table, { silent = true, desc = '[r]ust crates: e[X]tract into table' })

    vim.keymap.set('n', '<leader>rH', crates.open_homepage, { silent = true, desc = '[r]ust crates: [H]omepage' })
    vim.keymap.set('n', '<leader>rR', crates.open_repository, { silent = true, desc = '[r]ust crates: [R]epository' })
    vim.keymap.set('n', '<leader>rD', crates.open_documentation, { silent = true, desc = '[r]ust crates: [D]ocumentation' })
    vim.keymap.set('n', '<leader>rC', crates.open_crates_io, { silent = true, desc = '[r]ust crates: open [C]rates.io' })
  end,
}
