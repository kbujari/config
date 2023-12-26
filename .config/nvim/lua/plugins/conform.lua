return {
  "stevearc/conform.nvim",
  enabled = true,
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>b",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format buffer",
    },
  },
  dependencies = {
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      build = ":MasonToolsInstall",
      opts = {
        ensure_installed = {
          "black",
          "clang-format",
          "codespell",
          "isort",
          "markdownlint",
          "prettierd",
          "rustywind",
          "shellharden",
          "shfmt",
        },
      },
    },
  },
  opts = {
    formatters_by_ft = {
      bash = { "shellharden", "shfmt" },
      zsh = { "shellharden" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      sh = { "shellharden", "shfmt" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      json = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      yaml = { "prettierd" },
      astro = { "rustywind", "prettierd" },
      svelte = { "rustywind", "prettierd" },
      lua = { "stylua" },
      tex = {
        "latexindent", --[[ "codespell" ]]
      },
      python = { "isort", "black" },
      markdown = {
        "markdownlint",
        "prettierd",
      },
      ["_"] = { "codespell" },
    },
  },
}
