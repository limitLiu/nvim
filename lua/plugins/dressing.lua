local ok, dressing = pcall(require, "dressing")

if ok then
  local opts = {
    enabled = true,
    border = "single",
    insert_only = false,
    start_in_insert = true,
    title_pos = "left",
  }

  dressing.setup {
    input = {
      get_config = function()
        if
          vim.api.nvim_get_option_value("filetype", { filetype = "NvimTree" })
        then
          return opts
        end
      end,
    },
  }
end
