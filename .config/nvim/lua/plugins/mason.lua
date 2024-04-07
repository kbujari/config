return {
  "williamboman/mason.nvim",
  enabled = true,
  build = function() pcall(vim.cmd, "MasonUpdate") end,
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
        "html",
        "lua_ls",
        "pylsp",
        "rust_analyzer",
        "svelte",
        "texlab",
        "tsserver",
        "yamlls"
      },
      handlers = {
        function(server)
          lc[server].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,

        ["rust_analyzer"] = function()
          lc.rust_analyzer.setup({
            settings = {
              ["rust-analyzer"] = {
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          })
        end,

        ["yamlls"] = function()
          lc.yamlls.setup({
            schemas = {
              kubernetes = "*.yaml",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] =
              "roles/tasks/*.{yml,yaml}",
              ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] =
              "*play*.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
              "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
              "*docker-compose*.{yml,yaml}",
            }
          })
        end,

        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                  Lua = {
                    runtime = {
                      version = "LuaJIT",
                    },
                    workspace = {
                      checkThirdParty = false,
                      library = {
                        vim.env.VIMRUNTIME,
                      },
                    },
                  },
                })
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
              end
              return true
            end,
          })
        end,
      },
    })
  end,
}
