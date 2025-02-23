return {
	"saghen/blink.cmp",
	version = "v0.12.4",
  enabled = true,
	event = { "BufReadPost" },
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	opts = {
		keymap = { preset = "super-tab" },
	},
}
