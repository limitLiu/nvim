require("nvim-treesitter").setup {
  install_dir = vim.fn.stdpath "data" .. "/site",
}
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
