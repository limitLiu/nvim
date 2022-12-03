local cmp = requirePlugin "cmp"
local ui = require "lsp.ui"

if cmp and ui then
  cmp.setup {
    snippet = {
      expand = function(args)
        -- For `vsnip` users.
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "cmp_tabnine" },
      { name = "vsnip" },
    }, { { name = "buffer" }, { name = "path" } }),

    mapping = require("common.keybindings").cmp(cmp),
    formatting = ui.formatting,
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
