local keymap = vim.api.nvim_set_keymap

-- unbind single <space> for better leader key
keymap("", "<Space>", "<Nop>", { noremap = true })

keymap("n", "<leader>u", "<cmd>Lazy home <CR>", { noremap = true, desc = "Update" })

-- navigate splits
keymap("n", "<C-h>", "<C-w>h", { noremap = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- resize splits
keymap("n", "<C-S-k>", ":resize -2<CR>", { noremap = true })
keymap("n", "<C-S-j>", ":resize +2<CR>", { noremap = true })
keymap("n", "<C-S-h>", ":vertical resize -2<CR>", { noremap = true })
keymap("n", "<C-S-l>", ":vertical resize +2<CR>", { noremap = true })

-- navigate tabs
keymap("n", "<TAB>", ":bnext<cr>", { noremap = true, desc = "Next buffer" })
keymap("n", "<S-TAB>", ":bprev<cr>", { noremap = true, desc = "Prev Buffer" })

-- close current tab
keymap("n", "<leader>w", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", { noremap = true, desc = "Close buffer" })

-- clear search
keymap("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", {})

-- Move lines up and down
keymap("n", "<S-Down>", "<Esc>:m+<CR>", {})
keymap("n", "<S-Up>", "<Esc>:m-2<CR>", {})

-- new file
keymap("n", "<leader>n", "<cmd>ene<cr>", { noremap = true, desc = "Create new file" })

-- don't accidently create macros when trying to quit
keymap("n", "Q", "q", {})
keymap("n", "q", "<nop>", {})

-- less disorienting scroll down
keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
