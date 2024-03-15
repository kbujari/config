local opt = vim.opt

opt.autoindent = true -- keep indent on new line
opt.autowrite = true -- save changes when switching buffer
opt.background = "dark" -- dark bg
opt.clipboard = "unnamedplus" -- use system clipboard
opt.cmdheight = 0 -- remove cmdline
opt.conceallevel = 2 -- hide markers for bold and italic
opt.encoding = "utf-8" -- text encoding
opt.expandtab = true -- spaces instead of tabs
opt.fileencoding = "utf-8" -- file encoding
opt.ignorecase = true -- ignore case
opt.incsearch = true -- jump to line when search hits
opt.laststatus = 3 -- global statusline
opt.mouse = "a" -- enable mouse
opt.number = true -- enable line numbers
opt.numberwidth = 1 --line numbers width
opt.pumblend = 10 -- blend popup menu
opt.pumheight = 10 -- max entries in popup
opt.relativenumber = true -- relative line numbers
opt.scrolloff = 4 -- lines of context
opt.shiftround = true --round indent
opt.shiftwidth = 2 -- size of an indent
opt.showmode = false -- statusline handles this
opt.signcolumn = "yes" -- show signcolumn when needed
opt.smartcase = true -- don't ignore case when using caps
opt.smartindent = true -- insert autoindents
opt.smarttab = true -- also read shiftwidth when tabbing
opt.spelllang = { "en" } -- spellcheck langs
opt.splitbelow = true -- new windows below current
opt.splitkeep = "screen" --keep text on same line with window
opt.splitright = true -- new windows right of current
opt.swapfile = false -- disable swapfile
opt.tabstop = 2 -- number of spaces tabs count for
opt.termguicolors = true -- truecolor support
opt.timeout = true -- enable timeout for keymaps
opt.timeoutlen = 300 -- timeout from mapped sequence
opt.title = true -- add file info to window title
opt.updatetime = 200 -- time before 'idle'
opt.virtualedit = "block" -- freely move cursor in visual mode
opt.wrap = false -- disable line wrap

vim.filetype.add({
  pattern = {
    ["${XDG_CONFIG_HOME}/zathura/zathurarc"] = "zathurarc",
    ["${XDG_CONFIG_HOME}/waybar/config"] = "json",
  },
})
