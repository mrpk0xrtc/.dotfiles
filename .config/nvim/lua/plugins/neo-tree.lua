return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.loaded_netrw = 0
			vim.g.loaded_netrwPlugin = 0
		end,
		config = function()
			require("neo-tree").setup({
				event_handlers = {
					{
						event = "vim_buffer_enter",
						handler = function() end,
					},
				},
				sources = {
					"filesystem",
					"git_status",
					"buffers",
					"document_symbols",
				},
				source_selector = {
					winbar = true,
					statusline = false,
					sources = {
						{ source = "filesystem" },
						{ source = "buffers" },
						{ source = "git_status" },
						{ source = "document_symbols" },
					},
				},
				window = {
					position = "left",
					width = 40,
				},
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					follow_current_file = {
						enabled = false,
					},
				},
			})
		end,
	},
	{
		"Crysthamus/nvim-file-operations",
		dependencies = {
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
			require("nvim-file-operations").setup()
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					bo = {
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						buftype = { "terminal", "quickfix" },
					},
				},
			})
		end,
	},
}
