require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    ocaml = { "ocamlformat" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    objc = { "clang_format" },
    objcpp = { "clang_format" },
    dart = { "dart_format" },
    haskell = { "ormolu" },
    swift = { "swiftformat" },
    zig = { "zigfmt" },
    typescript = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },
    javascript = { "prettier", stop_after_first = true },
  },
  formatters = {
    rustfmt = {
      options = { default_edition = "2024" },
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
