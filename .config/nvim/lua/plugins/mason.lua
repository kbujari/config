return {
  "williamboman/mason.nvim",
  enabled = true,
  build = function()
    pcall(vim.cmd, "MasonUpdate")
  end,
  keys = {
    { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
  },
  config = function()
    local lc = require("lspconfig")
    require("mason").setup({
      ui = {
        border = "rounded",
        scrollbar = "║",
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "astro",
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "html",
        "texlab",
        "lua_ls",
        "marksman",
        "swift_mesonls",
        "pyright",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "terraformls",
        "tsserver",
        "yamlls",
      },
      handlers = {
        function(server_name)
          lc[server_name].setup({})
        end,

        ["lua_ls"] = function()
          lc.lua_ls.setup({
            settings = {
              Lua = {
                hint = { enable = true },
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
      },
    })
  end,
}
