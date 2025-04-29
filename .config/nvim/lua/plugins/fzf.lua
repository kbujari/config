return {
  "ibhagwan/fzf-lua",
  opts = {},
  keys = {
    { "<leader>f", "<cmd>FzfLua files<cr>", desc = "Search files" },
    { "<leader>h", "<cmd>FzfLua helptags<cr>", desc = "Search helptags" },
    { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    { "<leader>t", "<cmd>FzfLua colorschemes<cr>", desc = "Change colorscheme" },
    {
      "<leader>c",
      function(_)
        require("fzf-lua").files({ cwd = os.getenv("HOME") .. "/.config/nvim" })
      end,
      desc = "Configuration",
    },
  },
}
