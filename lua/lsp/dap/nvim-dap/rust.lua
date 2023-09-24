local extension_path =
  "~/.local/share/nvim/site/pack/packer/start/vimspector/gadgets/macos/CodeLLDB"
local codelldb_path = extension_path .. "/adapter/codelldb"
local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"

return {
  adapter = require("rust-tools.dap").get_codelldb_adapter(
    codelldb_path,
    liblldb_path
  ),
}
