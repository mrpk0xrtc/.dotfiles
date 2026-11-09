return {
	{
		"nvim-mini/mini.diff",
		version = false,
		config = function()
			require("mini.diff").setup()
		end,
	},
	{
		"andymass/vim-matchup",
		event = "BufReadPost",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
}
