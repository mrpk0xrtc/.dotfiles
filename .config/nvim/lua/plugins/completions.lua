return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
			"petertriho/cmp-git",
		},
		build = function()
			require("blink.cmp").build():pwait()
		end,

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "git" },
				providers = {
					git = {
						name = "git",
						module = "cmp_git.blink",
						opts = {},
					},
				},
			},
			fuzzy = { implementation = "rust" },
		},
	},
}
