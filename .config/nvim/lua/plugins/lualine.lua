return {
  "nvim-lualine/lualine.nvim",
  event = { "VimEnter" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      section_separators = "",
      component_separators = "",
      disabled_filetypes = { "alpha", "oil", "lazy", "mason", "TelescopePrompt", "toggleterm" },
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "progress" },
      lualine_c = { "filesize", "filename" },
      lualine_x = { "branch", "diff", "diagnostics", "encoding" },
      lualine_y = { "filetype" },
      lualine_z = { "location" },
    },
    inactive_sections = {},
    tabline = {},
    extensions = {},
  },
}
