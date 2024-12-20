return {
  "ibhagwan/fzf-lua",
  opts = {},
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Search files" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    { "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Change colorscheme" },
    {
      "<leader>fdc",
      function(_)
        require("fzf-lua").files({ cwd = os.getenv("HOME") .. "/.config/nvim" })
      end,
      desc = "Configuration",
    },
  },
}
