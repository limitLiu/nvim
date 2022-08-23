local null_ls = requirePlugin "null-ls"
if null_ls then
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_action = null_ls.builtins.code_actions
  null_ls.setup {
    debug = false,
    sources = {
      formatting.stylua,
      formatting.rustfmt,
      formatting.clang_format,
      formatting.prettier.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "css",
          "scss",
          "less",
          "html",
          "json",
          "yaml",
          "graphql",
        },
        prefer_local = "node_modules/.bin",
      },
      -- Diagnostics  ---------------------
      diagnostics.eslint.with {
        prefer_local = "node_modules/.bin",
      },
      -- code actions ---------------------
      code_action.gitsigns,
      code_action.eslint.with {
        prefer_local = "node_modules/.bin",
      },
    },
    -- #{m}: message
    -- #{s}: source name (defaults to null-ls if not specified)
    -- #{c}: code (if available)
    diagnostics_format = "[#{s}] #{m}",
  }
end
