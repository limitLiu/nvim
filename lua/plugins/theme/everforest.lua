local ok, everforest = pcall(require, "everforest")
if ok then
  everforest.setup {
    background = "soft",
    transparent_background_level = 0,
    italics = true,
    disable_italic_comments = false,
  }
end
