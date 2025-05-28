local lualine_require = require "lualine_require"

local modules = lualine_require.lazy_require {
  highlight = "lualine.highlight",
  utils = "lualine.utils.utils",
}

local M = lualine_require.require("lualine.component"):extend()

local default_options = {
  lsp_name = true,
  colored = true,
  icon_only = false,

  icon = "", -- f013
  symbols = {
    -- Use standard unicode characters for the spinner and done symbols:
    spinner = {
      "⠋",
      "⠙",
      "⠹",
      "⠸",
      "⠼",
      "⠴",
      "⠦",
      "⠧",
      "⠇",
      "⠏",
    },
    done = "✓",
    separator = " ",
  },
  -- List of LSP names to ignore (e.g., `null-ls`):
  ignore_lsp = {},
}

function M:init(options)
  -- Run `super()`.
  M.super.init(self, options)
  self.icon_hl_cache = {}

  -- Apply default options.
  self.options =
    vim.tbl_deep_extend("keep", self.options or {}, default_options)

  -- Apply symbols.
  self.symbols = self.options.symbols or {}

  ---The difference between the `begin` and `end` progress events for each LSP.
  ---
  ---@type table<integer, integer>
  self.lsp_work_by_client_id = {}

  -- Listen to progress updates only if `nvim` supports the `LspProgress` event.
  pcall(vim.api.nvim_create_autocmd, "LspProgress", {
    desc = "Update the Lualine LSP status component with progress",
    group = vim.api.nvim_create_augroup("lualine_lsp_progress", {}),
    ---@param event {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(event)
      local kind = event.data.params.value.kind
      local client_id = event.data.client_id

      local work = self.lsp_work_by_client_id[client_id] or 0
      local work_change = kind == "begin" and 1 or (kind == "end" and -1 or 0)

      self.lsp_work_by_client_id[client_id] = math.max(work + work_change, 0)

      -- Refresh Lualine to update the LSP status symbol if it changed.
      if (work == 0 and work_change > 0) or (work == 1 and work_change < 0) then
        require("lualine").refresh()
      end
    end,
  })
end

function M:update_status()
  local result = {}
  local processed = {}

  -- Backwards-compatible function to get the active LSP clients.
  ---@diagnostic disable-next-line: deprecated
  local get_lsp_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
  local clients = get_lsp_clients { bufnr = vim.api.nvim_get_current_buf() }

  -- Backwards-compatible function to get the current time in nanoseconds.
  local hrtime = (vim.uv or vim.loop).hrtime
  -- Advance the spinner every 80ms only once, not for each client (otherwise the spinners will skip steps).
  -- NOTE: the spinner symbols table is 1-indexed.
  local spinner_symbol =
    self.symbols.spinner[math.floor(hrtime() / (1e6 * 80)) % #self.symbols.spinner + 1]

  for _, client in ipairs(clients) do
    local status = ""
    local work = self.lsp_work_by_client_id[client.id]
    if work ~= nil and work > 0 then
      status = spinner_symbol
    elseif work ~= nil and work == 0 then
      status = self.symbols.done
    end

    -- Backwards-compatible function to check if a list contains a value.
    local list_contains = vim.list_contains or vim.tbl_contains
    -- Append the status to the LSP only if it supports progress reporting and is not ignored.
    if
      not processed[client.name]
      and not list_contains(self.options.ignore_lsp, client.name)
    then
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
        status = icon
      else
        if self.options.lsp_name then
          status = icon .. " " .. M:lsp_name() .. " " .. status
        else
          status = icon .. " " .. status
        end
      end

      table.insert(
        result,
        ((status and status ~= "") and (" " .. status) or "")
      )
      processed[client.name] = true
    end
  end
  return table.concat(result, self.symbols.separator)
end

function M:lsp_name()
  local msg = "-"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    --- @diagnostic disable-next-line:undefined-field
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

return M
