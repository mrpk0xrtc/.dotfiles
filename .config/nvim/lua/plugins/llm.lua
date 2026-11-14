return {
	{
		"Kurama622/llm.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
		config = function()
			require("llm").setup({
				display = {
					diff = {
						provider = "mini_diff", -- instead of the default provider
					},
				},
				url = "http://127.0.0.1:11434/api/chat",
				model = "qwen2.5-coder:3b",
				api_type = "ollama",
				max_tokens = 8192,
				keep_alive = "10m",
				app_handler = {
					-- Define a tool to explain selected code
					CodeExplain = {
						handler = "disposable_ask_handler", -- Use the flexible Q&A Handler
						-- You can pre-set a prompt, or leave it blank to enter it each time
						prompt = "Explain the following code:",
					},
					-- Define a tool to attach code to chat
					AttachToChat = {
						handler = "attach_to_chat_handler",
					},
					Ask = {
						handler = "disposable_ask_handler",
						opts = {
							position = {
								row = 2,
								col = 0,
							},
							title = " Ask ",
							inline_assistant = true,

							-- Whether to use the current buffer as context without selecting any text (the tool is called in normal mode)
							enable_buffer_context = true,
							diagnostic = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },

							-- display diff
							display = {
								mapping = {
									mode = "n",
									keys = { "d" },
								},
								action = nil,
							},
							-- accept diff
							accept = {
								mapping = {
									mode = "n",
									keys = { "Y", "y" },
								},
								action = nil,
							},
							-- reject diff
							reject = {
								mapping = {
									mode = "n",
									keys = { "N", "n" },
								},
								action = nil,
							},
							-- close diff
							close = {
								mapping = {
									mode = "n",
									keys = { "<esc>" },
								},
								action = nil,
							},
						},
					},
				},
			})
		end,
		keys = {
			{ "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
			{ "<leader>ae", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>" },
			{ "<leader>aa", mode = "v", "<cmd>LLMAppHandler AttachToChat<cr>" },
			{
				"<leader>ai",
				mode = { "n", "v" },
				"<cmd>LLMAppHandler Ask<cr>",
				desc = "Inline Assistant",
			},
		},
	},
}
