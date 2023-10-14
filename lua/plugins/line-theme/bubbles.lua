-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue     = '#80a0ff',
  cyan     = '#79dac8',
  black    = '#080808',
  white    = '#c6c6c6',
  red      = '#ff5189',
  violet   = '#d183e8',
  grey     = '#303030',
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  magenta  = '#c678dd',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand "%:p:h"
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.violet, bg = colors.grey },
    b = { fg = colors.white, bg = colors.bg },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.blue, bg = colors.grey } },
  visual = { a = { fg = colors.cyan, bg = colors.grey } },
  replace = { a = { fg = colors.red, bg = colors.grey } },

  inactive = {
    a = { fg = colors.black, bg = colors.grey },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

local custom_filetype = require "plugins/line-theme/components/custom-filetype"
local custom_mode = require "plugins/line-theme/components/custom-mode"

local config = {
  options = {
    theme = bubbles_theme,
    -- component_separators = "|",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      { custom_mode, separator = { left = "" }, right_padding = 2 },
    },
    -- lualine_b = { "filename", "branch" },
    lualine_b = {
      "branch",
      {
        "diff",
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        custom_filetype,
        lsp_name = true,
        icon_only = false,
        -- icon = { align = "left" },
      },
      {
        "o:encoding", -- option component same as &encoding in viml
        fmt = string.lower, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = "bold" },
      },
      "progress",
    },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = {},
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

ins_left {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

local function ins_right_x(component)
  table.insert(config.sections.lualine_x, component)
end

require("lualine").setup(config)
