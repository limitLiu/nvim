local nvim_tree = requirePlugin "nvim-tree"
local keys = require("common.keybindings").nvim_tree_keys
if nvim_tree and keys then
  nvim_tree.setup {
    git = {
      enable = true,
      ignore = true,
    },
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    view = {
      mappings = {
        custom_only = false,
        list = keys,
      },
      -- side = "right",
      side = "left",
    },
  }
end
