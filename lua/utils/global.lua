function _G.requirePlugin(name)
  local ok, plugin = pcall(require, name)
  if not ok then
    vim.notify("Cannot find " .. name)
    return nil
  end
  return plugin
end
