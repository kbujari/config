function _G.searchDir()
  require("telescope.builtin").find_files({
    border = true,
  })
end

return {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  cmd = "Telescope",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Search files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Search in buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help tags" },
    { "<leader>fc", "<cmd>Telescope colorscheme preview=true<cr>", desc = "Change colorscheme" },
    {
      "<leader>fn",
      function()
        require("telescope.builtin").find_files({
          cwd = os.getenv("HOME") .. "/.config/nvim",
        })
      end,
      desc = "Search config files",
    },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      extensions = {},
      defaults = {
        layout_config = {
          height = 0.3,
          width = 0.8,
          preview_cutoff = 120,
          prompt_position = "bottom",
        },
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        path_display = { "smart" },
        winblend = 0,
        -- border = true,
        -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        normal_mode = true,
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
          "--hidden",
          "--glob",
          "!**/.git/*",
        },
        mappings = {
          i = {
            ["<Esc>"] = actions.close,
          },
        },
      },
      colorscheme = {
        enable_preview = true,
      },
      buffers = {
        initial_mode = "normal",
      },
    })

    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("fzf")
  end,
}
