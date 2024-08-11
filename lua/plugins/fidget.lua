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

  local local_config = {
    name = "",
    icon = "",
    ttl = 5,
    group_style = "Title",
    icon_style = "Special",
    annote_style = "Question",
    debug_style = "Comment",
    info_style = "Question",
    warn_style = "WarningMsg",
    error_style = "ErrorMsg",
    debug_annote = " ",
    info_annote = " ",
    warn_annote = " ",
    error_annote = " ",
    icon_on_left = true,
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

    notification = {
      -- vim.notify = fidget.notify
      override_vim_notify = true,
      filter = vim.log.levels.INFO,
      window = {
        align = "bottom",
        border = "single",
        normal_hl = "Comment",
        winblend = 0,
      },
      configs = { default = local_config },
    },
  }
end
