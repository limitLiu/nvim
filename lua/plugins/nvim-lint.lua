local ok, lint = pcall(require, "lint")
if not ok then
  vim.notify "Cannot find nvim-lint"
  return
end

lint.linters_by_ft = {
  swift = { "swiftlint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd(
  { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
  {
    group = lint_augroup,
    callback = function()
      require("lint").try_lint()
    end,
  }
)

vim.keymap.set("n", "<leader>ml", function()
  require("lint").try_lint()
end, { desc = "Lint file" })
