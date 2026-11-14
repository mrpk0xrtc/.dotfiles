return {
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			{ "nvim-mini/mini.bufremove", version = "*" },
			{ "nvim-tree/nvim-web-devicons" },
		},
		version = "*",
		config = function()
			require("bufferline").setup({
				options = {
					themable = true,
					custom_areas = {
						right = function()
							local result = {}
							local seve = vim.diagnostic.severity
							local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
							local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
							local info = #vim.diagnostic.get(0, { severity = seve.INFO })
							local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

							if error ~= 0 then
								table.insert(result, { text = "  " .. error, link = "DiagnosticError" })
							end

							if warning ~= 0 then
								table.insert(result, { text = "  " .. warning, link = "DiagnosticWarn" })
							end

							if hint ~= 0 then
								table.insert(result, { text = "  " .. hint, link = "DiagnosticHint" })
							end

							if info ~= 0 then
								table.insert(result, { text = "  " .. info, link = "DiagnosticInfo" })
							end
							return result
						end,
					},
					numbers = function(opts)
						return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
					end,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local s = " "
						for e, n in pairs(diagnostics_dict) do
							local sym = e == "error" and " " or (e == "warning" and " " or " ")
							s = s .. n .. sym
						end
						return s
					end,
					close_command = function(n)
						require("mini.bufremove").delete(n, false)
					end,
					right_mouse_command = function(n)
						require("mini.bufremove").delete(n, false)
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},
					hover = {
						enabled = true,
						delay = 150,
						reveal = { "close" },
					},
					indicator = {
						style = "underline",
					},
				},
			})
		end,
	},
}
