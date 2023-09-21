local ft = requirePlugin "guard.filetype"
if ft then
  ft("c"):fmt("clang-format"):lint "clang-tidy"

  require("guard").setup {
    fmt_on_save = true,
    lsp_as_default_formatter = false,
  }
end
