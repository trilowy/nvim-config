local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name
local mason_registry = require 'mason-registry'
local jdtls_path = mason_registry.get_package('jdtls'):get_install_path()

-- Determine OS
local os
if vim.fn.has 'windows' == 1 then
  os = 'win'
elseif vim.fn.has 'unix' == 1 then
  os = 'linux'
elseif vim.fn.has 'mac' == 1 then
  os = 'mac'
else
  print 'Unsupported OS for jdtls'
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  -- cmd = { vim.fn.stdpath 'data' .. '/mason/bin/jdtls.CMD' },
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. jdtls_path .. '/lombok.jar',
    '-jar',
    vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    jdtls_path .. '/config_' .. os,
    '-data',
    workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  -- root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },

  -- Add autocomplete of function parameters
  -- Also add snippets like "sysout"
  capabilities = {
    workspace = {
      configuration = true,
    },
    textDocument = {
      completion = {
        completionItem = {
          snippentSupport = true,
        },
      },
    },
  },

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      format = {
        -- settings = { url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml', profile = 'GoogleStyle' },
        settings = { url = vim.fn.expand '~/eclipse-formatter.xml', profile = 'eclipse-formatter' },
      },

      saveActions = {
        organizeImports = true,
        cleanup = true,
      },

      -- eclipse = {
      --   downloadSources = true,
      -- },

      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = 'JavaSE-21',
            path = '/usr/local/sdkman/candidates/java/21.0.5-tem/',
          },
          {
            name = 'JavaSE-17',
            path = '/usr/local/sdkman/candidates/java/17.0.13-tem/',
          },
          {
            name = 'JavaSE-11',
            path = '/usr/local/sdkman/candidates/java/11.0.25-tem/',
          },
        },
      },

      completion = {
        importOrder = {
          '',
          'java',
          'javax',
          '#',
        },
        favoriteStaticMembers = {
          'com.github.tomakehurst.wiremock.client.WireMock.*',
          'org.assertj.core.api.Assertions.*',
          'org.mockito.ArgumentMatchers.*',
          'org.mockito.Mockito.*',
          'org.mockito.MockitoAnnotations.*',
          'org.mockito.ArgumentMatchers.*',
          'org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*',
          'org.springframework.test.web.servlet.result.MockMvcResultHandlers.*',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
        },
        filteredTypes = {
          'com.sun.*',
          'io.micrometer.shaded.*',
          'java.awt.*',
          'jdk.*',
          'sun.*',
        },
      },

      cleanup = {
        actions = {
          'cleanup.array_with_curly',
          'cleanup.use_autoboxing',
          'cleanup.overridden_assignment_move_decl',
          'cleanup.primitive_comparison',
          'cleanup.system_property_file_encoding',
          'cleanup.remove_redundant_semicolons',
          'cleanup.qualify_static_member_accesses_through_subtypes_with_declaring_class',
          'cleanup.useless_continue',
          'cleanup.remove_redundant_type_arguments',
          'cleanup.remove_unused_imports',
          'cleanup.break_loop',
          'cleanup.pull_up_assignment',
          'cleanup.stringbuilder',
          'cleanup.no_super',
          'cleanup.arrays_fill',
          'cleanup.use_lambda',
          'cleanup.operand_factorization',
          'cleanup.simplify_lambda_expression_and_method_ref',
          'cleanup.always_use_blocks',
          'cleanup.stringconcat_to_textblock',
          'cleanup.system_property_path_separator',
          'cleanup.instanceof',
          'cleanup.add_missing_annotations',
          'cleanup.precompile_regex',
          'cleanup.boolean_literal',
          'cleanup.always_use_parentheses_in_expressions',
          'cleanup.add_missing_deprecated_annotations',
          'cleanup.no_string_creation',
          'cleanup.use_unboxing',
          'cleanup.standard_comparison',
          'cleanup.if_condition',
          'cleanup.system_property_line_separator',
          'cleanup.map_cloning',
          'cleanup.try_with_resource',
          'cleanup.use_this_for_non_static_method_access_only_if_necessary',
          'cleanup.reduce_indentation',
          'cleanup.primitive_parsing',
          'cleanup.make_local_variable_final',
          'cleanup.add_missing_override_annotations',
          'cleanup.use_blocks',
          'cleanup.multi_catch',
          'cleanup.pull_out_if_from_if_else',
          'cleanup.collection_cloning',
          'cleanup.redundant_comparator',
          'cleanup.remove_unused_private_types',
          'cleanup.system_property_boolean',
          'cleanup.lazy_logical_operator',
          'cleanup.bitwise_conditional_expression',
          'cleanup.use_directly_map_method',
          'cleanup.add_all',
          'cleanup.system_property_file_separator',
          'cleanup.stringbuilder_for_local_vars',
          'cleanup.controlflow_merge',
          'cleanup.primitive_serialization',
          'cleanup.comparing_on_criteria',
          'cleanup.do_while_rather_than_while',
          'cleanup.comparison_statement',
          'cleanup.extract_increment',
          'cleanup.make_private_fields_final',
          'cleanup.useless_return',
          'cleanup.instanceof_keyword',
          'cleanup.use_this_for_non_static_field_access_only_if_necessary',
          'cleanup.remove_trailing_whitespaces_all',
          'cleanup.one_if_rather_than_duplicate_blocks_that_fall_through',
          'cleanup.valueof_rather_than_instantiation',
          'cleanup.plain_replacement',
          'cleanup.remove_unnecessary_array_creation',
          'cleanup.remove_private_constructors',
          'cleanup.substring',
          'cleanup.ternary_operator',
          'cleanup.replace_deprecated_calls',
          'cleanup.merge_conditional_blocks',
          'cleanup.return_expression',
          'cleanup.system_property',
          'cleanup.unlooped_while',
          'cleanup.convert_to_enhanced_for_loop',
          'cleanup.remove_unused_private_fields',
          'cleanup.remove_redundant_modifiers',
          'cleanup.unreachable_block',
          'cleanup.redundant_falling_through_block_end',
          'cleanup.switch',
          'cleanup.also_simplify_lambda',
          'cleanup.number_suffix',
          'cleanup.remove_unnecessary_nls_tags',
          'cleanup.convert_to_switch_expressions',
          'cleanup.use_string_is_blank',
          'cleanup.qualify_static_member_accesses_through_instances_with_declaring_class',
          'cleanup.remove_unnecessary_casts',
          'cleanup.objects_equals',
          'cleanup.convert_functional_interfaces',
          'cleanup.else_if',
          'cleanup.boolean_value_rather_than_comparison',
          'cleanup.add_default_serial_version_id',
          'cleanup.remove_unused_private_methods',
          'cleanup.join',
          'cleanup.embedded_if',
          'cleanup.invert_equals',
          'cleanup.add_missing_override_annotations_interface_methods',
          'cleanup.strictly_equal_or_different',
          'cleanup.push_down_negation',
          'cleanup.evaluate_nullable',
          'cleanup.hash',
          'cleanup.stringconcat_stringbuffer_stringbuilder',
          'cleanup.double_negation',
          'cleanup.overridden_assignment',
          'cleanup.primitive_rather_than_wrapper',
        },
      },
    },
  },
}

-- Add autocomplete of function parameters
config.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<leader>jo', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = '[j]ava: [o]rganize imports' })
vim.keymap.set('n', '<leader>jv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = '[j]ava: extract [v]ariable' })
vim.keymap.set('v', '<leader>jv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = '[j]ava: extract [v]ariable' })
vim.keymap.set('n', '<leader>jc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = '[j]ava: extract [c]onstant' })
vim.keymap.set('v', '<leader>jc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = '[j]ava: extract [c]onstant' })
vim.keymap.set('v', '<leader>jm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = '[j]ava: extract [m]ethod' })

-- Add header snippet
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local function year()
  return vim.fn.strftime '%Y'
end

ls.add_snippets('java', {
  s('header', {
    t { '/*', ' *-----------------------------------------------------------------', '' },
    t ' * Ce code source est la propriété de TODO. Tous droits réservés, ',
    f(year, {}),
    t '.',
    t {
      '',
      ' * (C) Copyright TODO, ',
    },
    f(year, {}),
    t {
      '',
      ' *-----------------------------------------------------------------',
      ' */',
    },
  }),
})
