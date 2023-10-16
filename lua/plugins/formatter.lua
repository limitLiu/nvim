local ok, formatter = pcall(require, "formatter")

if ok then
  formatter.setup {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
      lua = { require("formatter.filetypes.lua").stylua },
      rust = { require("formatter.filetypes.rust").rustfmt },
      ocaml = { require("formatter.filetypes.ocaml").ocamlformat },
      haskell = { require("formatter.filetypes.haskell").stylish_haskell },
      c = { require("formatter.filetypes.c").clangformat },
      cpp = { require("formatter.filetypes.cpp").clangformat },
      ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
    },
  }

  vim.cmd [[
    augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost * FormatWrite
    augroup END
  ]]
end
