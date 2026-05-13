require("tree-sitter-manager").setup {
  highlight = true,
  parser_dir = vim.fn.stdpath "data" .. "/site/parser",
  query_dir = vim.fn.stdpath "data" .. "/site/queries",
}
-- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.wo[0][0].foldmethod = "expr"

-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
