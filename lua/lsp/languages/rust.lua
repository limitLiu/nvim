local common = require "lsp.languages.common"

local keybinding = function(b)
  local function buf(...)
    vim.api.nvim_buf_set_keymap(b, ...)
  end

  local opt = { noremap = true, silent = true }
  buf(
    "n",
    "K",
    "<cmd>lua require'rust-tools'.hover_actions.hover_actions()<CR>",
    opt
  )
end

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  handlers = common.handlers,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
    keybinding(buf)
  end,
  settings = {
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
      checkOnSave = {
        command = "clippy",
      },
      diagnostics = {
        disabled = { "unresolved-proc-macro" },
      },
      inlayHints = { locationLinks = false },
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

return {
  on_setup = function(server)
    local ok, rust_tools = pcall(require, "rust-tools")
    if not ok then
      server.setup(opts)
    else
      rust_tools.setup {
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
    end
  end,
}
