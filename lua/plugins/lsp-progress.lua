require("lsp-progress").setup {
  client_format = function(client_name, spinner, series_messages)
    if #series_messages == 0 then
      return nil
    end
    return {
      name = client_name,
      body = spinner,
    }
  end,

  format = function(client_messages)
    local messages_map = {}
    for _, cli_msg in ipairs(client_messages) do
      messages_map[cli_msg.name] = cli_msg.body
    end

    local lsp_clients = vim.lsp.get_clients()
    if #lsp_clients > 0 then
      local builder = {}
      for _, cli in ipairs(lsp_clients) do
        if
          type(cli) == "table"
          and type(cli.name) == "string"
          and string.len(cli.name) > 0
        then
          if messages_map[cli.name] then
            table.insert(builder, messages_map[cli.name])
          end
        end
      end
      if #builder > 0 then
        return table.concat(builder, " ")
      end
    end
    return ""
  end,
}
