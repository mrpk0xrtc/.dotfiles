return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"lewis6991/async.nvim",
		},
		lazy = false,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
