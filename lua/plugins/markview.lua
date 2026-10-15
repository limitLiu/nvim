local ok, spec = pcall(require, "markview.spec")
if ok then
  spec.config = vim.deepcopy(spec.default)
  spec.config.markdown = {
    enable = nil,
    block_quoutes = {},
    code_blocks = {},
    headings = {},
    horizontal_rules = {},
    list_items = {},
    tables = {},
    metadata_plus = {},
    metadata_minus = {},
    reference_definitions = {},
  }
end
