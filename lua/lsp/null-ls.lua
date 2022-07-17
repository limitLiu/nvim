local null_ls = requirePlugin "null-ls"
if null_ls then
  local formatting = null_ls.builtins.formatting
  null_ls.setup {
    debug = false,
    sources = {
      formatting.stylua,
      formatting.rustfmt,
      formatting.prettier.with {
        prefer_local = "node_modules/.bin",
      },
      formatting.clang_format,
    },
  }
end
