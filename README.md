# nvim config

**NeoVim v11+**

## Must be configured

First of all, create a Lua file named "config.lua" in the `lua` directory, it contains the following content:

```lua
return {
  colorscheme = "everforest",
  background = "light",
  python3_host_prog = "/usr/bin/python3",
  lua_line = "evil_lualine",
}
```
