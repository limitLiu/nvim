require("nvim-autopairs").setup()
local cmp_auto_pairs = require "nvim-autopairs.completion.cmp"
local cmp = require "cmp"
cmp.event:on("confirm_done", cmp_auto_pairs.on_confirm_done())
