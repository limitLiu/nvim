# nvim config

**NeoVim v11+**

## Must be configured

First of all, create a Lua file named "config.lua" in the `lua` directory, it contains the following content:

```lua
return {
  colorscheme = "everforest",
  background = "light",
  python3_host_prog = "/opt/homebrew/bin/python3",
  lua_line = "bubbles",
  ignore = { "rust-analyzer", "hls" },
}
```
