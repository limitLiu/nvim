-- Copyright (c) 2020-2021 hoob3rt
-- MIT license, see LICENSE for more details.

local symbols = {
  unix = "",
  dos = "",
  mac = "",
}

local Mode = {}

---@return string current mode name
function Mode.get_mode()
  local format = vim.bo.fileformat
  if symbols[format] == nil then
    return format
  else
    return symbols[format]
  end
end

return Mode.get_mode
