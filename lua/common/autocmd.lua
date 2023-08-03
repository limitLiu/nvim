local autoGroup = vim.api.nvim_create_augroup("autoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd
local file_type = {
  "*.res",
  "*.rs",
  "*.ml",
  "*.lua",
  "*.json",
  "*.c",
  "*.cc",
  "*.cpp",
}

autocmd("BufWritePre", {
  group = autoGroup,
  pattern = file_type,
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

-- autocmd("InsertLeave", {
--   group = autoGroup,
--   pattern = {
--     "*.res",
--     "*.rs",
--     "*.ml",
--     "*.lua",
--     "*.scss",
--     "*.js",
--     "*.ts",
--     "*.tsx",
--     "*.json",
--     "*.kt",
--   },
--   callback = function()
--     local buf = vim.api.nvim_get_current_buf()
--     vim.api.nvim_buf_call(buf, function()
--       vim.cmd "silent! update"
--     end)
--   end,
-- })

-- vim.cmd "au TextYankPost * lua vim.highlight.on_yank {on_visual = true}"
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { on_visual = true }
  end,
  group = autoGroup,
  pattern = "*",
})

-- Go to last used hidden buffer when deleting a buffer
-- autocmd("BufEnter", {
--   nested = true,
--   callback = function()
--     local api = require "nvim-tree.api"
--     if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
--       vim.defer_fn(function()
--         api.tree.toggle { find_file = true, focus = true }
--         api.tree.toggle { find_file = true, focus = true }
--         vim.cmd "wincmd p"
--       end, 0)
--     end
--   end,
-- })
