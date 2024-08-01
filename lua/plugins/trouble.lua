local ok, trouble = pcall(require, "trouble")

if ok then
  trouble.setup {
    win = { position = "right", pinned = true },
  }
end
