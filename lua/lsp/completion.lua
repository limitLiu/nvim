local cmpOk, cmp = pcall(require, "cmp")
local uiOk, ui = pcall(require, "lsp.ui")

if cmpOk and uiOk then
  cmp.setup {
    snippet = {
      expand = function(args)
        -- For `vsnip` users.
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    sources = cmp.config.sources {
      { name = "nvim_lsp" },
      -- { name = "cmp_tabnine" },
      { name = "vsnip" },
      { name = "buffer" },
      { name = "path" },
    },

    mapping = require("common.keybindings").cmp(cmp),
    formatting = ui.formatting,
    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require "clangd_extensions.cmp_scores",
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  }

  -- Use buffer source for `/`.
  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end
