return {
  "stevearc/oil.nvim",
  keys = {
    { "<leader>.", "<cmd>lua require('oil').open()<cr>", desc = "File Manager" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    default_file_explorer = true,
    columns = { "icon", "size" },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<C-s>"] = "actions.select_split",
      ["<C-h>"] = "actions.select_vsplit",
    },
  },
}
