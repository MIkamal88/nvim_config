return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		event = "InsertEnter",
		config = function()
			local types = require("luasnip.util.types")

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").setup({
				history = true,
				delete_check_events = "TextChanged",
				-- Display a cursor-like placeholder in unvisited nodes
				-- of the snippet.
				ext_opts = {
					[types.insertNode] = {
						unvisited = {
							virt_text = { { "|", "Conceal" } },
							virt_text_pos = "inline",
						},
					},
				},
			})
		end,
	},
	{
		"saghen/blink.cmp",
		---@class PluginLspOpts
		opts = {
			enabled = function()
				return not vim.list_contains({ "lazy" }, vim.bo.filetype)
					and vim.bo.buftype ~= "prompt"
					and vim.b.completion ~= false
			end,
			completion = {
				menu = {
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
