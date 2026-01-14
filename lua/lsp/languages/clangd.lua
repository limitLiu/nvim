local common = require "lsp.languages.common"

local opts = {
  cmd = {
    "clangd",
    "--background-index",
    "-j=6",
    "--query-driver=/usr/bin/**/clang-*,/usr/bin/clang,/usr/bin/clang++,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++,/Applications/CLion.app/Contents/bin/clang/mac/aarch64/bin/clang-*",
    "--clang-tidy",
    "--clang-tidy-checks=*",
    "--all-scopes-completion",
    "--cross-file-rename",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--pch-storage=memory",
  },
  flags = common.flags,
  filetypes = { "c", "cpp" },
  handlers = common.handlers,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
    local ok, inlay_hints = pcall(require, "clangd_extensions.inlay_hints")
    if ok then
      inlay_hints.setup_autocmd()
      inlay_hints.set_inlay_hints()
    end
  end,
}

opts.capabilities = vim.tbl_deep_extend(
  "force",
  common.capabilities,
  { offsetEncoding = "utf-16" }
)

return opts
