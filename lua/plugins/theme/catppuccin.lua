local ok, catppuccin = pcall(require, "catppuccin")
if ok then
  catppuccin.setup {
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "macchiato",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = { "bold" },
      functions = { "bold" },
      keywords = { "italic" },
      strings = { "bold" },
      variables = {},
      numbers = {},
      booleans = { "bold" },
      properties = {},
      types = { "bold" },
      operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
      treesitter = true,
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      notify = false,
      mini = false,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  }
end
