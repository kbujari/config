-- remove trailing whitespace on write
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})

-- remove trailing lines containing only whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s#\($\n\s*\)\+\%$##e]],
})

-- wrap and spellcheck in text filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true

    vim.api.nvim_set_keymap("n", "j", [[v:count ? 'j' : 'gj']], { expr = true })
    vim.api.nvim_set_keymap("n", "k", [[v:count ? 'k' : 'gk']], { expr = true })
  end,
})

-- fix conceal for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- remove lsplines on Lazy window
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lazy" },
  callback = function()
    vim.diagnostic.config({ virtual_lines = false })
  end,
})
