return {
	"neovim/nvim-lspconfig",
	enabled = true,
	event = { "BufReadPost", "BufNewFile" },
	command = { "LspInfo", "LspInstall", "LspUninstall" },
	dependencies = { "saghen/blink.cmp" },
	config = function(_, opts)
		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			require("lspconfig")[server].setup(config)
		end
	end,
	opts = {
		servers = {
			bashls = {},
			clangd = {
				cmd = {
					"clangd",
					"--clang-tidy",
					"--completion-style=detailed",
					"--fallback-style=Google",
					"--function-arg-placeholders",
					"--header-insertion=iwyu",
					"--header-insertion-decorators",
				},
			},
			cssls = {},
      fennel_ls= {},
			lua_ls = {
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
							checkThirdParty = true,
							library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
						},
					})
				end,
			},
			nil_ls = {},
			rust_analyzer = {
				["settings.rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
			pylsp = {},
			tinymist = {},
		},
	},
}
