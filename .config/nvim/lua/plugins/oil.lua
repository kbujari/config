return {
  "stevearc/oil.nvim",
  enabled = true,
  keys = {
    { "<leader>.", "<cmd>lua require('oil').open()<cr>", desc = "File Manager" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    default_file_explorer = true,
    lsp_file_methods = {
      autosave_changes = true,
    },
    columns = { "icon", "size" },
    view_options = {
      show_hidden = true,
    },
  },
}
