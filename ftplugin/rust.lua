require "lsp.completion"
local ok, m = pcall(require, "utils.cmp")
if ok then
  m.cmp()
end
