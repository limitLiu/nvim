local installer = require("nvim-lsp-installer")

local servers = {
  sumneko_lua = require("lsp.lua"),
  rust_analyzer = require("lsp.rust"),
  tsserver = {},
  clangd = {},
  rescriptls = require("lsp.rescript"),
  sourcekit = {},
  hls = {},
}

for name, _ in pairs(servers) do
  local server_is_found, server = installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

installer.on_server_ready(function(serve)
  local opts = servers[serve.name]
  if opts then
    opts.on_attach = function(_, bufnr)
      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end
      require("keybinding").map_lsp(buf_set_keymap)
    end
    opts.flags = {
      debounce_text_changes = 150,
    }
    if serve.name == "rust_analyzer" then
      require("rust-tools").setup({
        server = vim.tbl_deep_extend("force", serve:get_default_options(), opts),
      })
      serve:attach_buffers()
    else
      serve:setup(opts)
    end
  end
end)
