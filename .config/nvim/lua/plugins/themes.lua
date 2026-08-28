return {
	{
		"nuvic/flexoki-nvim",
		name = "flexoki",
		priority = 1000,
		config = function()
			require("flexoki").setup({
				variant = "moon",
			})
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
		opts = {},
		priority = 1000,
		config = function(_, opts)
			require("tokyodark").setup(opts)
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "darker",
			})
			require("onedark").load()
		end,
	},
	{
		"dasupradyumna/midnight.nvim",
		lazy = false,
		priority = 1000,
	},
}
