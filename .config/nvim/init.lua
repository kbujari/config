local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = vim.keycode("<Space>")

-- vim.cmd.colorscheme("wildcharm")

vim.cmd.colorscheme("quiet")
vim.cmd([[highlight clear SignColumn]])
vim.cmd([[highlight Keyword gui=bold]])
vim.cmd([[highlight Comment gui=italic]])
vim.cmd([[highlight Constant guifg=#999999]])
vim.cmd([[highlight NormalFloat guibg=#333333]])

opt.background = "dark" -- dark bg
opt.clipboard = "unnamedplus" -- use system clipboard
opt.colorcolumn = "72" -- enable wrap column
opt.cmdheight = 0 -- remove cmdline
opt.expandtab = true -- spaces instead of tabs
opt.ignorecase = true -- ignore case
opt.mouse = "a" -- enable mouse
opt.relativenumber = true -- relative line numbers
opt.shiftwidth = 2 -- size of an indent
opt.smartcase = true -- don't ignore case when using caps
opt.smartindent = true -- insert autoindents
opt.smarttab = true -- also read shiftwidth when tabbing
opt.signcolumn = "yes" -- always reserve space for signcol
opt.swapfile = false -- disable swapfile
opt.tabstop = 2 -- number of spaces tabs count for
opt.timeoutlen = 300 -- timeout from mapped sequence
opt.title = true -- add file info to window title
opt.virtualedit = "block" -- freely move cursor in visual mode
opt.wrap = false -- disable wrapping by default

-- manually set filetypes for special files
vim.filetype.add({
	pattern = {
		["${XDG_CONFIG_HOME}/zathura/zathurarc"] = "zathurarc",
		["${XDG_CONFIG_HOME}/waybar/config"] = "json",
	},
})

-- remove trailing whitespace on write
autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- remove trailing lines containing only whitespace
autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s#\($\n\s*\)\+\%$##e]],
})

-- highlight yanked text
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})

-- autowrap and spellcheck in text filetypes
autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 72
	end,
})

-- remove lsplines on Lazy window
autocmd({ "FileType" }, {
	pattern = { "lazy" },
	callback = function()
		vim.diagnostic.config({ virtual_lines = false })
	end,
})

-- unbind single <space> for better leader key
keymap("", "<Space>", "<Nop>", { noremap = true })

-- navigate splits
keymap("n", "<C-h>", "<C-w>h", { noremap = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- resize splits
keymap("n", "<C-S-k>", ":resize -2<cr>", { noremap = true })
keymap("n", "<C-S-j>", ":resize +2<cr>", { noremap = true })
keymap("n", "<C-S-h>", ":vertical resize -2<cr>", { noremap = true })
keymap("n", "<C-S-l>", ":vertical resize +2<cr>", { noremap = true })

-- navigate tabs
keymap("n", "<TAB>", ":bnext<cr>", { noremap = true, desc = "Next buffer" })
keymap("n", "<S-TAB>", ":bprev<cr>", { noremap = true, desc = "Prev Buffer" })

-- close current tab
keymap("n", "<leader>w", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", { noremap = true, desc = "Close buffer" })

-- clear search
keymap("n", "<Esc><Esc>", "<cmd>nohlsearch<cr>", {})

-- don't accidently create macros when trying to quit
keymap("n", "Q", "q", {})
keymap("n", "q", "<nop>", {})

-- less disorienting scroll down
keymap("n", "<C-d>", "<C-d>zz", { noremap = true })

-- setup plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = { notify = false },
	performance = {
		cache = { enabled = true },
	},
})
