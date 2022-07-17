vim.opt.termguicolors = true
local plugin = requirePlugin "bufferline"
if plugin then
  plugin.setup {
    options = {
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  }
end
