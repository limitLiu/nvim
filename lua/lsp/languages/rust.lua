local common = require "lsp.languages.common"

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  handlers = common.handlers,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
    vim.lsp.inlay_hint.enable(true, { bufnr = buf })
  end,
  default_settings = {
    ["rust-analyzer"] = {
      procMacro = {
        enable = true,
      },
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = { enable = true },
      },
      check = {
        command = "clippy",
      },
      checkOnSave = true,
      diagnostics = {
        disabled = { "unresolved-proc-macro", "needless_return" },
      },
      inlayHints = {
        lifetimeElisionHints = {
          enable = true,
          useParameterNames = true,
        },
      },
    },
  },
}

local hover_actions = {
  border = common.border,
  -- Maximal width of the hover window. Nil means no max.
  max_width = nil,

  -- Maximal height of the hover window. Nil means no max.
  max_height = nil,

  -- whether the hover action window gets automatically focused
  -- default: false
  auto_focus = false,
}

vim.g.rustaceanvim = {
  server = opts,
  dap = require "lsp.dap.nvim-dap.rust",
  tools = {
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
    hover_actions = hover_actions,
  },
}
