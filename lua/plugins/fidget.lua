local ok, fidget = pcall(require, "fidget")
if ok then
  fidget.spinner.patterns.dice = {
    "󰇊",
    "󰇋",
    "󰇌",
    "󰇍",
    "󰇎",
    "󰇏",
  }
  fidget.setup {
    progress = {
      display = {
        progress_icon = { pattern = "dice", period = 1 },
        done_icon = "✔",
        overrides = {
          rust_analyzer = { name = "rust-analyzer" },
          lua_ls = { name = "lua-ls" },
        },
      },
    },
  }
  fidget.notification.default_config = {
    icon_on_left = false,
  }
  vim.notify = fidget.notify
end
