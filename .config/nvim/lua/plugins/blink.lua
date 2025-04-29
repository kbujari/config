return {
	"saghen/blink.cmp",
	version = "v1.1.1",
  enabled = true,
	event = { "BufReadPost" },
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	opts = {
		keymap = { preset = "super-tab" },
	},
}
