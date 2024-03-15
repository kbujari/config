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
          "prettierd",
          "shellharden",
          "shfmt",
        },
      },
    },
  },
  opts = {
    -- rest are handled by lsp formatter
    formatters_by_ft = {
      astro = { "prettierd" },
      bash = { "shellharden", "shfmt" },
      css = { "prettierd" },
      html = { "prettierd" },
      javascript = { "prettierd" },
      json = { "prettierd" },
      markdown = { "prettierd" },
      sh = { "shellharden", "shfmt" },
      svelte = { "prettierd" },
      typescript = { "prettierd" },
      yaml = { "prettierd" },
      zsh = { "shellharden", "shfmt" },
    },
  },
}
