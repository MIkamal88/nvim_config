local DISABLED_FILETYPES = {
	"DiffviewFileHistory",
	"DiffviewFiles",
	"checkhealth",
	"copilot-chat",
	"fugitive",
	"git",
	"gitcommit",
	"help",
	"lspinfo",
	"man",
	"neo-tree",
	"qf",
	"query",
	"scratch",
	"startuptime",
}

return {
	{
		"saghen/blink.cmp",
		opts = {
			enabled = function()
				local buftype = vim.bo.buftype
				local filetype = vim.bo.filetype
				return not (
					buftype == "nofile"
					or buftype == "nowrite"
					or buftype == "prompt"
					or vim.tbl_contains(DISABLED_FILETYPES, filetype)
				)
			end,

			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = {
						border = "single",
						max_height = 20,
						max_width = 50,
					},
				},
				list = {
					selection = {
						auto_insert = false,
					},
				},
				menu = {
					-- border = "single",
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									-- default kind icon
									local icon = ctx.kind_icon
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr then
											icon = color_item.abbr
										end
									end
									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									-- default highlight group
									local highlight = "BlinkCmpKind" .. ctx.kind
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr_hl_group then
											highlight = color_item.abbr_hl_group
										end
									end
									return highlight
								end,
							},
						},
					},
				},
			},

			signature = {
				enabled = true,
				window = {
					border = "single",
					max_height = 20,
					max_width = 50,
				},
			},

			keymap = {
				preset = "default",
				["<Enter>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
			},
		},
	},
}
