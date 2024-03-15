return {
  "lervag/vimtex",
  enabled = true,
  ft = "tex",
  keys = {
    { "<leader>ll", "<cmd>VimtexCompile<cr>", desc = "VimtexCompile" },
    { "<leader>lc", "<cmd>VimtexClean<cr>", desc = "VimtexClean" },
    { "<leader>ls", "<cmd>VimtexStatus<cr>", desc = "VimtexStatus" },
    { "<leader>lt", "<cmd>VimtexTocToggle<cr>", desc = "VimtexTocToggle" },
  },
  config = function() vim.g.vimtex_view_method = "zathura" end,
}
