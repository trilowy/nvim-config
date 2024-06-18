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

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { silent = true, desc = 'Crates: ' .. desc })
    end

    local mapv = function(keys, func, desc)
      vim.keymap.set('v', keys, func, { silent = true, desc = 'Crates: ' .. desc })
    end

    map('<leader>ct', crates.toggle, '[C]rates [T]oggle')
    map('<leader>cr', crates.reload, '[C]rates [R]eload')

    map('<leader>cv', crates.show_versions_popup, '[C]rates show [V]ersions')
    map('<leader>cf', crates.show_features_popup, '[C]rates show [F]eatures')
    map('<leader>cd', crates.show_dependencies_popup, '[C]rates show [D]ependencies')

    map('<leader>cu', crates.update_crate, '[C]rates [U]pdate')
    mapv('<leader>cu', crates.update_crates, '[C]rates [U]pdate')
    map('<leader>cU', crates.upgrade_crate, '[C]rates [U]pgrade')
    mapv('<leader>cU', crates.upgrade_crates, '[C]rates [U]pgrade')
    map('<leader>cA', crates.upgrade_all_crates, '[C]rates upgrade [A]ll crates')

    map('<leader>cx', crates.expand_plain_crate_to_inline_table, '[C]rates expand to inline table')
    map('<leader>cX', crates.extract_crate_into_table, '[C]rates extract into table')

    map('<leader>cH', crates.open_homepage, '[C]rates [H]omepage')
    map('<leader>cR', crates.open_repository, '[C]rates [R]epository')
    map('<leader>cD', crates.open_documentation, '[C]rates [D]ocumentation')
    map('<leader>cC', crates.open_crates_io, '[C]rates open [C]rates.io')
  end,
}
