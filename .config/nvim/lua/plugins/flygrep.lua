return {
	{
		"wsdjeg/flygrep.nvim",
		event = "VeryLazy",
		dependencies = { "wsdjeg/job.nvim" },
		config = function()
			require("flygrep").setup()
		end,
	},
}
