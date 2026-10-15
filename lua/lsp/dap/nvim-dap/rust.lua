local extension_path, codelldb_path, liblldb_path = "", "", ""

if current_os:find "Windows" then
  extension_path = vim.env.HOME
    .. "/AppData/Local/nvim-data/lazy/vimspector/gadgets/windows/CodeLLDB"
  codelldb_path = extension_path .. "/adapter/codelldb.exe"
  liblldb_path = extension_path .. "/lldb/bin/liblldb.dll"
else
  extension_path = vim.env.HOME
    .. "/.local/share/nvim/lazy/vimspector/gadgets/"
    .. (current_os == "Linux" and "linux" or "macos")
    .. "/CodeLLDB"
  codelldb_path = extension_path .. "/adapter/codelldb"
  liblldb_path = extension_path
    .. "/lldb/lib/liblldb"
    .. (current_os == "Linux" and ".so" or ".dylib")
end

return {
  adapter = require("rustaceanvim.config").get_codelldb_adapter(
    codelldb_path,
    liblldb_path
  ),
}
