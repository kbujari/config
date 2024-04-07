return {
  "stevearc/conform.nvim",
  enabled = true,
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>b",
      function() require("conform").format({ async = true, lsp_fallback = true }) end,
      desc = "Format buffer",
    },
  },
  dependencies = {
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      build = ":MasonToolsInstall",
      cmd = "MasonToolsInstall",
      opts = {
        ensure_installed = {
          "prettier",
          "shellharden",
          "shfmt",
        },
      },
    },
  },
  opts = {
    -- rest are handled by lsp formatter
    formatters_by_ft = {
      astro = { "prettier" },
      bash = { "shellharden", "shfmt" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
      sh = { "shellharden", "shfmt" },
      svelte = { "prettier" },
      typescript = { "prettier" },
      yaml = { "prettier" },
      zsh = { "shellharden", "shfmt" },
    },
    formatters = {
      prettier = {
        prepend_args = { "--prose-wrap", "always" }
      }
    },
  },
}
