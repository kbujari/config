return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  command = { "LspInfo", "LspInstall", "LspUninstall" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      build = ":MasonUpdate",
      keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Open Mason" } },
      opts = {
        ensure_installed = {
          "prettierd",
          "shellharden",
          "shfmt",
          "stylua",
        },
        ui = { border = "rounded" },
      },
    },
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lc = require("lspconfig")
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    require("lspconfig").nixd.setup({
      cmd = { "nixd" },
      settings = {
        nixd = {
          nixpkgs = {
            expr = "import <nixpkgs> { }",
          },
          formatting = {
            command = { "nixpkgs-fmt" },
          },
        },
      },
    })
    require("mason-lspconfig").setup({
      ensure_installed = {
        "astro",
        "bashls",
        "clangd",
        "cssls",
        "html",
        "lua_ls",
        "prosemd_lsp",
        "pylsp",
        "rust_analyzer",
        "ts_ls",
        "yamlls",
      },
      handlers = {
        function(server)
          lc[server].setup({ capabilities = capabilities })
        end,

        ["clangd"] = function()
          lc.clangd.setup({
            capabilities = capabilities,
            cmd = {
              "clangd",
              "--clang-tidy",
              "--completion-style=detailed",
              "--fallback-style=Google",
              "--function-arg-placeholders",
              "--header-insertion=iwyu",
              "--header-insertion-decorators",
            },
          })
        end,

        ["rust_analyzer"] = function()
          lc.rust_analyzer.setup({
            capabilities = capabilities,
            ["settings.rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          })
        end,

        ["lua_ls"] = function()
          lc.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                format = { enable = false },
                hint = {
                  enable = true,
                  arrayIndex = "Disable",
                },
                completion = { callSnippet = "Replace" },
              },
            },
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                return
              end

              client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = { version = "LuaJIT" },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME .. "/lua",
                  },
                },
              })
            end,
          })
        end,
      },
    })
  end,
}
