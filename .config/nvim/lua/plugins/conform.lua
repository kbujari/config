return {
	"stevearc/conform.nvim",
	event = { "LspAttach", "BufWritePre" },
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>b",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			astro = { "prettier" },
			bash = { "shellharden", "shfmt" },
			c = { lsp_format = "fallback" },
			cpp = { lsp_format = "fallback" },
			css = { "prettier" },
			html = { "prettier" },
			htmldjango = { "prettier" },
			javascript = { "prettier" },
			json = { "prettier" },
			lua = { "stylua", lsp_format = "fallback" },
			markdown = { "prettier", "injected" },
			nix = { "nixpkgs_fmt" },
			python = { "black" },
			rust = { "rustfmt" },
			sh = { "shellharden", "shfmt" },
			svelte = { "prettier" },
			typescript = { "prettier" },
			typst = { "typstyle" },
			yaml = { "prettier" },
			zsh = { "shellharden", "shfmt" },
		},
	},
}
