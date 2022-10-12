local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local opts = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemery = {
        enable = false,
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, buf)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    local function buf_set_map(...)
      vim.api.nvim_buf_set_keymap(buf, ...)
    end
    require("common.keybindings").map_lsp(buf_set_map)
  end,
}

return {
  on_setup = function(server)
    local options = require("lua-dev").setup { lspconfig = opts }
    if options then
      server.setup(options)
    end
  end,
}
