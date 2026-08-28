local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

vim.keymap.set(
	"n",
	"<Leader>q",
	':lua require("mini.bufremove").delete(0, true)<CR>',
	{ desc = "Close Buffer", silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>w",
	':w<CR>:lua require("mini.bufremove").delete()<CR>',
	{ desc = "Save and Close Buffer", silent = true }
)

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic popup" })

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format" })

vim.keymap.set("n", "<C-t>", function()
	require("menu").open("default")
end, {})

vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
	require("menu.utils").delete_old_menus()
	vim.cmd.exec('"normal! \\<RightMouse>"')
	local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
	local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
	require("menu").open(options, { mouse = true, border = true })
end, {})

vim.keymap.set("n", "<Leader>dc", require("dap").continue, { desc = "Debug: Continue" })
vim.keymap.set("n", "<Leader>dt", require("dap").toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>do", require("dap").step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<Leader>di", require("dap").step_into, { desc = "Debug: Step Into" })

vim.keymap.set("n", "<Leader>du", require("dap").step_out, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<Leader>dr", require("dap").repl.open, { desc = "Debug: Open Repl" })
vim.keymap.set("n", "<Leader>dl", require("dap").run_last, { desc = "Debug: Run Last" })
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)

vim.api.nvim_set_keymap('n', '<F6>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-F6>',
     "<cmd>CompilerStop<cr>"
  .. "<cmd>CompilerRedo<cr>",
 { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-F7>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
