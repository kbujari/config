return {
  "NvChad/nvim-colorizer.lua",
  enabled = true,
  event = "BufReadPre",
  opts = {
    filetypes = { "*" },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = true,
      AARRGGBB = true,
      rgb_fn = true,
      hsl_fn = true,
      mode = "background",
      tailwind = true,
    },
  },
}
