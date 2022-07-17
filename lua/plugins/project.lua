local ok, project = pcall(require, "project_nvim")
if not ok then
  vim.notify "Cannot find project_nvim"
  return
end

vim.g.nvim_respect_buf_cwd = 1
project.setup {
  detection_methods = { "pattern" },
  patterns = {
    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
    "package.json",
    ".sln",
  },
}

local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify "Cannot find telescope"
  return
end
pcall(telescope.load_extension, "projects")
