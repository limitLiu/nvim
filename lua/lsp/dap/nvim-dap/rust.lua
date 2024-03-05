local extension_path = os.getenv "HOME"
  .. "/.local/share/nvim/lazy/vimspector/gadgets/macos/CodeLLDB"
local codelldb_path = extension_path .. "/adapter/codelldb"
local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"

return {
  adapter = require("rustaceanvim.config").get_codelldb_adapter(
    codelldb_path,
    liblldb_path
  ),
}
