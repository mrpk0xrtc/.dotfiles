-- lua/plugins/blink.lua
return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"rafamadriz/friendly-snippets",
			-- Treesitter-colored labels, using your theme's syntax colors
			{ "xzbdmw/colorful-menu.nvim", opts = {} },
			-- Color swatches for hex / rgb / tailwind (these show the actual color)
			{
				"brenoprata10/nvim-highlight-colors",
				opts = { render = "virtual", enable_tailwind = true },
			},
		},

		config = function()
			----------------------------------------------------------------------
			-- 🎨 Theme-driven highlights: each kind borrows its color from a
			--    standard syntax group of the active colorscheme.
			----------------------------------------------------------------------
			local kind_source = {
				Text = "String",
				Method = "Function",
				Function = "Function",
				Constructor = "@constructor",
				Field = "@variable.member",
				Variable = "@variable",
				Class = "Type",
				Interface = "Structure",
				Module = "@module",
				Property = "@property",
				Unit = "Number",
				Value = "Number",
				Enum = "Type",
				Keyword = "Keyword",
				Snippet = "Special",
				Color = "Special",
				File = "Directory",
				Reference = "Special",
				Folder = "Directory",
				EnumMember = "Constant",
				Constant = "Constant",
				Struct = "Structure",
				Event = "Special",
				Operator = "Operator",
				TypeParameter = "Type",
				Copilot = "String",
			}

			-- Resolve a group's foreground (following links), with fallbacks
			local function fg(...)
				for _, group in ipairs({ ... }) do
					local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
					if ok and hl and hl.fg then
						return hl.fg
					end
				end
			end

			local function set_highlights()
				local set = vim.api.nvim_set_hl

				-- Colored kind icons + kind text
				for kind, group in pairs(kind_source) do
					set(0, "BlinkCmpKind" .. kind, {
						fg = fg(group, "Normal"),
						bold = true,
					})
				end

				-- Window chrome follows your theme's float / popup styling
				set(0, "BlinkCmpMenu", { link = "Pmenu" })
				set(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
				set(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
				set(0, "BlinkCmpScrollBarThumb", { link = "PmenuThumb" })
				set(0, "BlinkCmpScrollBarGutter", { link = "PmenuSbar" })
				set(0, "BlinkCmpDoc", { link = "NormalFloat" })
				set(0, "BlinkCmpDocBorder", { link = "FloatBorder" })
				set(0, "BlinkCmpDocSeparator", { link = "FloatBorder" })
				set(0, "BlinkCmpSignatureHelp", { link = "NormalFloat" })
				set(0, "BlinkCmpSignatureHelpBorder", { link = "FloatBorder" })

				-- Text accents
				set(0, "BlinkCmpLabel", { link = "Pmenu" })
				set(0, "BlinkCmpLabelMatch", { fg = fg("Special", "Search"), bold = true })
				set(0, "BlinkCmpLabelDeprecated", { fg = fg("Comment"), strikethrough = true })
				set(0, "BlinkCmpLabelDetail", { fg = fg("Comment"), italic = true })
				set(0, "BlinkCmpLabelDescription", { fg = fg("Comment"), italic = true })
				set(0, "BlinkCmpSource", { fg = fg("Comment"), italic = true })
				set(0, "BlinkCmpGhostText", { fg = fg("Comment"), italic = true })
				set(0, "BlinkCmpSignatureHelpActiveParameter", {
					fg = fg("Special", "Search"),
					bold = true,
					underline = true,
				})
			end

			set_highlights()
			-- Colorschemes clear highlights on load, so re-derive after every switch
			vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

			----------------------------------------------------------------------
			-- ⚙️ Blink setup
			----------------------------------------------------------------------
			require("blink.cmp").setup({
				keymap = {
					preset = "default",
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<CR>"] = { "accept", "fallback" },
					["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
					["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<C-u>"] = { "scroll_documentation_up", "fallback" },
					["<C-d>"] = { "scroll_documentation_down", "fallback" },
				},

				appearance = {
					nerd_font_variant = "mono",
					kind_icons = {
						Text = "󰉿",
						Method = "󰊕",
						Function = "󰊕",
						Constructor = "",
						Field = "󰜢",
						Variable = "󰀫",
						Class = "󰠱",
						Interface = "",
						Module = "",
						Property = "󰜢",
						Unit = "󰑭",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "󰏘",
						File = "󰈙",
						Reference = "󰈇",
						Folder = "󰉋",
						EnumMember = "",
						Constant = "󰏿",
						Struct = "󰙅",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "",
					},
				},

				completion = {
					accept = { auto_brackets = { enabled = true } },
					list = { selection = { preselect = true, auto_insert = false } },

					menu = {
						border = "rounded",
						winblend = 8,
						scrollbar = true,
						draw = {
							treesitter = { "lsp" },
							padding = 1,
							gap = 1,
							columns = {
								{ "kind_icon" },
								{ "label", "label_description", gap = 1 },
								{ "kind", "source_name", gap = 1 },
							},
							components = {
								label = {
									width = { fill = true, max = 60 },
									text = function(ctx)
										return require("colorful-menu").blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu").blink_components_highlight(ctx)
									end,
								},

								kind_icon = {
									text = function(ctx)
										local icon = ctx.kind_icon
										if ctx.item.source_name == "LSP" then
											local color_item = require("nvim-highlight-colors").format(
												ctx.item.documentation,
												{ kind = ctx.kind }
											)
											if color_item and color_item.abbr ~= "" then
												icon = color_item.abbr
											end
										end
										return icon .. ctx.icon_gap
									end,
									highlight = function(ctx)
										local hl = "BlinkCmpKind" .. ctx.kind
										if ctx.item.source_name == "LSP" then
											local color_item = require("nvim-highlight-colors").format(
												ctx.item.documentation,
												{ kind = ctx.kind }
											)
											if color_item and color_item.abbr_hl_group then
												hl = color_item.abbr_hl_group
											end
										end
										return hl
									end,
								},

								kind = {
									highlight = function(ctx)
										return "BlinkCmpKind" .. ctx.kind
									end,
								},
							},
						},
					},

					documentation = {
						auto_show = true,
						auto_show_delay_ms = 150,
						window = { border = "rounded", winblend = 8, max_width = 80, max_height = 20 },
					},

					ghost_text = { enabled = true },
				},

				signature = {
					enabled = true,
					window = { border = "rounded", winblend = 8, show_documentation = false },
				},

				sources = { default = { "lsp", "path", "snippets", "buffer" } },

				cmdline = {
					keymap = { preset = "cmdline" },
					completion = {
						menu = { auto_show = true },
						ghost_text = { enabled = true },
					},
				},

				fuzzy = { implementation = "prefer_rust_with_warning" },
			})
		end,
	},
}
