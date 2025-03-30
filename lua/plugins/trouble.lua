local ok, trouble = pcall(require, "trouble")

if ok then
  trouble.setup {
    auto_jump = false,
    auto_close = true,
    debug = false,
    auto_open = false,
    auto_refresh = false,
    win = { type = "float" },
  }
end
