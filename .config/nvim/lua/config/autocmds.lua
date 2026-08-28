vim.opt.updatetime = 1000

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("Neotree filesystem reveal left")
	end,
})
