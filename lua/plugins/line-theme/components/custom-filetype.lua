-- Copyright (c) 2020-2021 hoob3rt
-- MIT license, see LICENSE for more details.
-- Lsp server name .

local lualine_require = require "lualine_require"
local modules = lualine_require.lazy_require {
  highlight = "lualine.highlight",
  utils = "lualine.utils.utils",
}
local M = lualine_require.require("lualine.component"):extend()

local default_options = {
  colored = true,
  icon_only = false,
}

function M:init(options)
  M.super.init(self, options)
  self.options =
    vim.tbl_deep_extend("keep", self.options or {}, default_options)
  self.icon_hl_cache = {}
end

function M.update_status()
  local ft = vim.bo.filetype or ""
  return modules.utils.stl_escape(ft)
end

function M:lsp_name()
  local msg = "-"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if
      filetypes
      and vim.fn.index(filetypes, buf_ft) ~= -1
      and client.name ~= "null-ls"
    then
      return client.name
    end
  end
  return msg
end

function M:apply_icon()
  if not self.options.icons_enabled then
    return
  end

  local icon, icon_highlight_group
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    icon, icon_highlight_group = devicons.get_icon(vim.fn.expand "%:t")
    if icon == nil then
      icon, icon_highlight_group =
        devicons.get_icon_by_filetype(vim.bo.filetype)
    end

    if icon == nil and icon_highlight_group == nil then
      icon = ""
      icon_highlight_group = "DevIconDefault"
    end
    if self.options.colored then
      local highlight_color =
        modules.utils.extract_highlight_colors(icon_highlight_group, "fg")
      if highlight_color then
        local default_highlight = self:get_default_hl()
        local icon_highlight = self.icon_hl_cache[highlight_color]
        if
          not icon_highlight
          or not modules.highlight.highlight_exists(
            icon_highlight.name .. "_normal"
          )
        then
          icon_highlight =
            self:create_hl({ fg = highlight_color }, icon_highlight_group)
          self.icon_hl_cache[highlight_color] = icon_highlight
        end
        icon = self:format_hl(icon_highlight) .. icon .. default_highlight
      end
    end
  else
    local is_ok = vim.fn.exists "*WebDevIconsGetFileTypeSymbol"
    if is_ok ~= 0 then
      icon = vim.fn.WebDevIconsGetFileTypeSymbol()
    end
  end

  if not icon then
    return
  end

  if self.options.icon_only then
    self.status = icon
  elseif
    type(self.options.icon) == "table" and self.options.icon.align == "right"
  then
    if self.options.lsp_name then
      self.status = M:lsp_name() .. " " .. icon
    else
      self.status = self.status .. " " .. icon
    end
  else
    if self.options.lsp_name then
      self.status = icon .. " " .. M:lsp_name()
    else
      self.status = icon .. " " .. self.status
    end
  end
end

return M
