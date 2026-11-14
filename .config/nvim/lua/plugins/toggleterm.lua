return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "horizontal",
				size = 8,
				open_mapping = [[<leader>th]],
				start_in_insert = true,
				hide_numbers = true,
			})
		end,
	},
}
