local ok, fidget = pcall(require, "fidget")
if ok then
  fidget.spinner.patterns.dice = {
    "", "", "", "", "", ""
  }

  fidget.setup {
    progress = {
      display = {
        progress_icon = { pattern = "dice", period = 1 },
        done_icon = "✔",
        overrides = {
          rust_analyzer = { name = "rust-analyzer" },
          lua_ls = { name = "lua" },
        },
      },
    },
  }
  fidget.notification.default_config = {
    name = "",
  }
  vim.notify = fidget.notify
end
