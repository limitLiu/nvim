local ok, dap = pcall(require, "dap")
local dapUIOk, dap_ui = pcall(require, "dapui")
local dapVirtualTextOk, dap_virtual_text =
  pcall(require, "nvim-dap-virtual-text")

if dapVirtualTextOk then
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

if dapUIOk and ok then
  dap_ui.setup {
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
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
      indent = 1,
    },
  }
  dap.listeners.before.attach.dapui_config = dap_ui.open
  dap.listeners.before.launch.dapui_config = dap_ui.open
  dap.listeners.before.event_terminated.dapui_config = dap_ui.close
  dap.listeners.before.event_exited.dapui_config = dap_ui.close
  require("common.keybindings").map_dap()
end
