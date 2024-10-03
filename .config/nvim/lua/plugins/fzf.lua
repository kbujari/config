return {
  "ibhagwan/fzf-lua",
  opts = {},
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Search files" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    { "<leader>fc", "<cmd>Telescope colorscheme preview=true<cr>", desc = "Change colorscheme" },
    {
      "<leader>fn",
      function(_)
        require("fzf-lua").files({ cwd = os.getenv("XDG_CONFIG_HOME") .. "/nvim" })
      end,
      desc = "Search nvim",
    },
  },
}
