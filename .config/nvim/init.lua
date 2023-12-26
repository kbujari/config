local core = {
  "core/keymaps",
  "core/settings",
  "core/autocmd",
  "core/lazy",
}

for _, module in ipairs(core) do
  local ok = pcall(require, module)
  if not ok then
    return
  end
end
