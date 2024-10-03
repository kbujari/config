return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufWritePre" },
  cmd = "ConformInfo",
  dependencies = {
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      build = ":MasonToolsInstall",
      cmd = "MasonToolsInstall",
      opts = {
        ensure_installed = {
          "black",
          "nixpkgs-fmt",
          "prettierd",
          "shellharden",
          "shfmt",
          "stylua",
        },
      },
    },
  },
  opts = {
    formatters_by_ft = {
      astro = { "prettierd" },
      bash = { "shellharden", "shfmt" },
      css = { "prettierd" },
      html = { "prettierd" },
      javascript = { "prettierd" },
      json = { "prettierd" },
      lua = { "stylua" },
      nix = { "nixpkgs_fmt" },
      markdown = { "prettierd", "injected" },
      sh = { "shellharden", "shfmt" },
      python = { "black" },
      svelte = { "prettierd" },
      typescript = { "prettierd" },
      yaml = { "prettierd" },
      zsh = { "shellharden", "shfmt" },
    },
  },
  keys = {
    {
      "<leader>b",
      function()
        require("conform").format({ lsp_format = "fallback", async = true })
      end,
      desc = "Format Buffer",
    },
  },
}
