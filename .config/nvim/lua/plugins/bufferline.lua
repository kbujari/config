return {
  "akinsho/bufferline.nvim",
  enabled = true,
  event = "VimEnter",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<TAB>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-TAB>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<leader>w", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", desc = "Close buffer" },
  },
  opts = {
    options = {
      mode = "buffers",
      indicator = {
        style = "icon",
      },
      max_name_length = 15,
      truncate_names = true,
      diagnostics = "nvim_lsp",
      separator_style = "thin",
      always_show_bufferline = false,
    },
  },
}
