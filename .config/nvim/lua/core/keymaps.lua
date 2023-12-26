local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navigate splits
keymap("n", "<C-h>", "<C-w>h", { noremap = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- Resize splits
keymap("n", "<C-S-k>", ":resize -2<CR>", { noremap = true })
keymap("n", "<C-S-j>", ":resize +2<CR>", { noremap = true })
keymap("n", "<C-S-h>", ":vertical resize -2<CR>", { noremap = true })
keymap("n", "<C-S-l>", ":vertical resize +2<CR>", { noremap = true })

-- Clear search when esc esc
keymap("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", {})

-- Move lines up and down
keymap("n", "<S-Down>", "<Esc>:m+<CR>", {})
keymap("n", "<S-Up>", "<Esc>:m-2<CR>", {})

-- Better tabbing
keymap("n", "<", "<gv", {})
keymap("n", ">", ">gv", {})

keymap("n", "<leader>n", "<cmd>ene<cr>", { noremap = true, desc = "New" })

-- Don't accidently create macros when trying to quit
keymap("n", "Q", "q", {})
keymap("n", "q", "<nop>", {})

-- Less disorienting scroll down
keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
