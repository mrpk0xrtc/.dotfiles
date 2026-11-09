return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
		config = function()
			local hooks = require("ibl.hooks")

			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "IblScope", { fg = "#900000" })
			end)

			require("ibl").setup({
				scope = {
					enabled = true,
					show_start = true,
					show_end = false,
					highlight = "IblScope",
					char = "│",
					include = {
						node_type = { ["*"] = { "*" } }, -- every node can be a scope
					},
				},
			})
		end,
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
