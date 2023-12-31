local opts = {
  swapfile = false,
  showmode = false,
  updatetime = 0,
  encoding = "utf-8",
  fileencoding = "utf-8",
  smartindent = true,
  smarttab = true,
  expandtab = true,
  autoindent = true,
  incsearch = true,
  shell = "/usr/bin/zsh",
  mouse = "a",
  pumheight = 15,
  ruler = true,
  conceallevel = 0,
  tabstop = 2,
  number = true,
  background = "dark",
  virtualedit = "onemore",
  ignorecase = true,
  smartcase = true,
  laststatus = 3,
  title = true,
  shiftwidth = 2,
  cmdheight = 1,
  numberwidth = 1,
  termguicolors = true,
  signcolumn = "yes",
  hidden = true,
  timeoutlen = 500,
  lazyredraw = true,
  synmaxcol = 240,
  wrap = false,
}

local disable = {
  netrw = 1,
  netrwPlugin = 1,
  netrwSettings = 1,
  netrwFileHandlers = 1,
  gzip = 1,
  zip = 1,
  zipPlugin = 1,
  tar = 1,
  tarPlugin = 1,
  getscript = 1,
  getscriptPlugin = 1,
  vimball = 1,
  vimballPlugin = 1,
  logipat = 1,
  rrhelper = 1,
  spellfile = 1,
  matchit = 1,
  loaded_python3_provider = 1,
  loaded_python_provider = 1,
  loaded_node_provider = 1,
  loaded_ruby_provider = 1,
  loaded_perl_provider = 1,
  loaded_2html_plugin = 1,
  loaded_getscript = 1,
  loaded_getscriptPlugin = 1,
  loaded_gzip = 1,
  loaded_tar = 1,
  loaded_tarPlugin = 1,
  loaded_rrhelper = 1,
  loaded_vimball = 1,
  loaded_vimballPlugin = 1,
  loaded_zip = 1,
  loaded_zipPlugin = 1,
  loaded_tutor = 1,
  loaded_rplugin = 1,
  loaded_logiPat = 1,
  loaded_netrwSettings = 1,
  loaded_netrwFileHandlers = 1,
  loaded_syntax = 1,
  loaded_synmenu = 1,
  loaded_optwin = 1,
  loaded_compiler = 1,
  loaded_bugreport = 1,
  loaded_ftplugin = 1,
  did_load_ftplugin = 1,
  did_indent_on = 1,
}

for k, v in pairs(opts) do
  vim.opt[k] = v
end

for k, v in pairs(disable) do
  vim.g[k] = v
end
