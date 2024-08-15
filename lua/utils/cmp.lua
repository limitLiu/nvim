local M = {}

function M.cmp()
  local ok, cmp_auto_pairs = pcall(require, "nvim-autopairs.completion.cmp")
  local is_ok, cmp = pcall(require, "cmp")
  if ok and is_ok then
    cmp.event:on("confirm_done", cmp_auto_pairs.on_confirm_done())
  end
end

return M
