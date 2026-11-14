vim.opt.updatetime = 1000

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("Neotree filesystem reveal left")
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function(args)
		if vim.api.nvim_buf_get_name(args.buf) == "" then
			return
		end
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if
				buf ~= args.buf
				and vim.api.nvim_buf_get_name(buf) == ""
				and vim.bo[buf].buftype == ""
				and not vim.bo[buf].modified
				and #vim.fn.win_findbuf(buf) == 0
			then
				pcall(vim.api.nvim_buf_delete, buf, {})
			end
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "SatelliteBar", { bg = "#999999", force = true })
  end,
})
