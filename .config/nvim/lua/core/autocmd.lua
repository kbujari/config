local api = vim.api

-- remove trailing whitespace
api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- remove trailing lines containing only whitespace
api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s#\($\n\s*\)\+\%$##e]],
})

-- enable line wrap for certain file types
api.nvim_create_autocmd({ "FileType" }, {
  -- group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- remove lsplines on Lazy window
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lazy" },
  callback = function()
    vim.diagnostic.config({ virtual_lines = false })
  end,
})

-- enable normal window keybinds inside of terminal
api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "term://*toggleterm#*" },
  callback = function()
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = 0 })
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { buffer = 0 })
  end,
})
