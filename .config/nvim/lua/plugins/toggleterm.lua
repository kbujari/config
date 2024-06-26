return {
  "akinsho/toggleterm.nvim",
  enabled = true,
  version = "*",
  cmd = "ToggleTerm",
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
  },
  opts = {
    size = 20,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      width = 130,
      -- height = 60,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    winbar = { enabled = true },
  },
}
