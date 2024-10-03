return {
  "stevearc/oil.nvim",
  keys = {
    { "<leader>.", "<cmd>lua require('oil').open()<cr>", desc = "File Manager" },
  },
  opts = {
    default_file_explorer = true,
    lsp_file_methods = {
      autosave_changes = true,
    },
    columns = { "size" },
    view_options = {
      show_hidden = true,
    },
  },
}
