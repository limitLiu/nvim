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
    swift = { "swiftformat", "swift_format", stop_after_first = true },
    zig = { "zigfmt" },
    typescript = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },
    javascript = { "prettier", stop_after_first = true },
    gdscript = { "gdscript-formatter" },
  },
  formatters = {
    rustfmt = {
      options = { default_edition = "2024" },
    },
    ["gdscript-formatter"] = {
      append_args = { "--use-spaces", "--indent-size", "2" },
    },
  },
  format_on_save = {
    timeout_ms = 3000,
    lsp_fallback = true,
  },
}
