local ok, trouble = pcall(require, "trouble")

if ok then
  trouble.setup {
    position = "right",
  }
end
