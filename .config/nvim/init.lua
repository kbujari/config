vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local core = {
  "core/autocmd",
  "core/keymaps",
  "core/lazy",
  "core/options",
}

for _, module in ipairs(core) do
  local ok = pcall(require, module)
  if not ok then return end
end
