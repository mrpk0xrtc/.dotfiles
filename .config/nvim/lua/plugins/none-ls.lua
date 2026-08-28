return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvimtools/none-ls-extras.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.completion.spell,
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.mypy,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.prettier,
				},
			})
		end,
	},
}
