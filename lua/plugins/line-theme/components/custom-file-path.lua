local lualine_require = require "lualine_require"
local M = lualine_require.require("lualine.component"):extend()
local modules = lualine_require.lazy_require {
  highlight = "lualine.highlight",
  utils = "lualine.utils.utils",
}

local default_options = { is_absolute = false }

function M:init(options)
  M.super.init(self, options)

  self.options =
    vim.tbl_deep_extend("keep", self.options or {}, default_options)
end

local function get_absolute_path()
  return vim.fn.expand "%:~"
end

local function get_relative_path()
  local function get_workspace()
    local gitdir = vim.fn.finddir(".git", vim.fn.expand "%:p:h" .. ";")
    return gitdir ~= "" and vim.fn.fnamemodify(gitdir, ":h") or ""
  end

  local current_file = vim.fn.expand "%:p"
  local git_path = get_workspace()

  if git_path ~= "" then
    return vim.fn.fnamemodify(current_file, ":~:" .. git_path .. "/..")
  else
    return ""
  end
end

function M.update_status()
  local ft = vim.bo.filetype or ""
  return modules.utils.stl_escape(ft)
end

function M:apply_icon()
  if self.options.is_absolute then
    self.status = get_absolute_path()
  else
    self.status = get_relative_path()
  end
end

return M
