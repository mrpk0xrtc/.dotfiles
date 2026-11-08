return {
	"Kurama622/llm.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
	config = function()
		require("llm").setup({
			url = "http://127.0.0.1:11434/api/chat",
			model = "qwen2.5-coder:3b",
			api_type = "ollama",
			max_tokens = 8192,
			keep_alive = "5m",
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
				GenerateCode = {
					handler = "disposable_ask_handler",
					opts = {
						-- Key configuration: allow using the current buffer as context without selecting text
						enable_buffer_context = true,
						-- You can pre-set some display options
						title = " Generate ",
						inline_assistant = true,
						-- Diff-related mappings (accept/reject), similar to action_handler's confirmation flow
						display = { mapping = { mode = "n", keys = { "d" } } },
						accept = { mapping = { mode = "n", keys = { "Y", "y" } } },
						reject = { mapping = { mode = "n", keys = { "N", "n" } } },
					},
				},
			},
		})
	end,
	keys = {
		{ "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
		{ "<leader>ae", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>" },
		{ "<leader>aa", mode = "v", "<cmd>LLMAppHandler AttachToChat<cr>" },
		{ "<leader>gc", mode = {"n", "v"}, "<cmd>LLMAppHandler GenerateCode<cr>", desc = "Generate Code with Context" },
	},
}
