vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local core = {
  "core/autocmd",
  "core/keymaps",
  "core/options",
  "core/lazy",
}

for _, module in ipairs(core) do
  local ok = pcall(require, module)
  if not ok then
    return
  end
end

vim.cmd.colorscheme("quiet")
vim.cmd([[highlight clear SignColumn]])
vim.cmd([[highlight Keyword gui=bold]])
vim.cmd([[highlight Comment gui=italic]])
vim.cmd([[highlight Constant guifg=#999999]])
vim.cmd([[highlight NormalFloat guibg=#333333]])
