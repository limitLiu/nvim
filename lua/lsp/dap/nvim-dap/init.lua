local dap = requirePlugin "dap"
local dap_ui = requirePlugin "dapui"
local dap_virtual_text = requirePlugin "nvim-dap-virtual-text"

if dap_virtual_text then
  dap_virtual_text.setup { commented = true }
end

vim.fn.sign_define("DapBreakpoint", {
  text = "🛑",
  texthl = "LspDiagnosticsSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "󰁕",
  texthl = "LspDiagnosticsSignInformation",
  linehl = "DiagnosticUnderlineInfo",
  numhl = "LspDiagnosticsSignInformation",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "󰃤",
  texthl = "LspDiagnosticsSignHint",
  linehl = "",
  numhl = "",
})

if dap_ui and dap then
  dap_ui.setup {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "o", "<CR>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    layouts = {
      {
        elements = {
          "scopes",
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 10,
        position = "bottom",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil, -- Can be integer or nil.
    },
  }
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dap_ui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dap_ui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dap_ui.close()
  end

  require("common.keybindings").map_dap()
end
