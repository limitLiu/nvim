local ok, illuminate = pcall(require, "illuminate")
if ok then
  illuminate.configure {
    providers = {
      "lsp",
      "treesitter",
    },
  }
end
