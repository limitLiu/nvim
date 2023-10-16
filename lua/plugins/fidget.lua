local ok, fidget = pcall(require, "fidget")
if ok then
  fidget.setup {
    text = {
      spinner = "dice", -- animation shown when tasks are ongoing
      done = "✔", -- character shown when all tasks are complete
      commenced = "Started", -- message shown when task starts
      completed = "Completed", -- message shown when task completes
    },
  }
end
