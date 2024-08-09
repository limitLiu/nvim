local ok, xcodebuild = pcall(require, "xcodebuild")

if ok then
  xcodebuild.setup {
    auto_save = false,
  }
end
