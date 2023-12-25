local ok, nerd_icons = pcall(require, "nerdicons")
if ok then
  nerd_icons.setup {
    border = "single",
    prompt = "󰨭 ",
    preview_prompt = " ",
    width = 0.5,
    down = "<C-n>",
    up = "<C-p>",
    copy = "<C-y>",
  }
end
