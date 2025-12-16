return {
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-highlight-colors").setup({
				render = "virtual",
				virtual_symbol = "■",
				virtual_symbol_prefix = "",
				virtual_symbol_suffix = " ",
				virtual_symbol_position = "inline",
				enable_hex = true,
				enable_short_hex = true,
				enable_rgb = true,
				enable_hsl = true,
				enable_hsl_without_function = true,
				enable_var_usage = true,
				enable_named_colors = true,
				enable_tailwind = false, -- handled by tailwind-tools.nvim
				custom_colors = {
					{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
					{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
				},
				exclude_filetypes = {},
				exclude_buftypes = {},
			})
		end,
	},
	{
		"notken12/base46-colors",
		config = function()
			local c = require("rxyhn.palette")
			c.base08 = "#f26e74"
			local hl = vim.api.nvim_set_hl
			local function set_highlights()
				hl(0, "LSPInlayHint", { fg = "#3B464A" })
				hl(0, "Visual", { fg = "NONE", bg = c.one_bg2 })
				hl(0, "NeoTreeDirectoryIcon", { fg = c.yellow, bg = "NONE" })
				hl(0, "NeoTreeDirectoryName", { fg = c.yellow, bg = "NONE" })
				hl(0, "NeoTreeGitModified", { fg = c.yellow, bg = "NONE" })
				hl(0, "Identifier", { fg = "#f2cdcd", bg = "NONE", sp = "NONE" })
				hl(0, "DiagnosticError", { fg = c.base08, bg = "NONE" })
				hl(0, "LspDiagnosticsDefaultError", { fg = c.base08, bg = "NONE" })
				hl(0, "LspDiagnosticsVirtualTextError", { fg = c.base08, bg = "NONE" })
				hl(0, "LspDiagnosticsFloatingError", { fg = c.base08, bg = "NONE" })
				hl(0, "DiagnosticSignError", { fg = c.base08, bg = "NONE" })
				hl(0, "LspDiagnosticsSignError", { fg = c.base08, bg = "NONE" })
				hl(0, "LspDiagnosticsError", { fg = c.base08, bg = "NONE" })
				hl(0, "CursorLine", { fg = "NONE", bg = c.one_bg2 })
				hl(0, "GitSignsCurrentLineBlame", { fg = "#3e445e" })
				hl(0, "String", { fg = "#82c29c", bg = "NONE" })
				hl(0, "guibg", { fg = "NONE", bg = "NONE" })
				hl(0, "Normal", { fg = "NONE", bg = "NONE" })
				hl(0, "NormalFloat", { fg = "NONE", bg = "NONE" })
				hl(0, "MsgArea", { fg = "NONE", bg = "NONE" })
				hl(0, "NormalNC", { fg = "NONE", bg = "NONE" })
				hl(0, "FloatBorder", { fg = "#45475A", bg = "NONE" })
				hl(0, "SnacksPickerTitle", { bg = "#7aa2f7", fg = "NONE" })
				hl(0, "SnacksPickerPreview", { bg = "NONE" })
				hl(0, "SnacksPickerList", { bg = "NONE" })
				hl(0, "SnacksPickerListTitle", { bg = "#9ece6a", fg = "NONE" })
				hl(0, "SnacksPickerInputTitle", { bg = "NONE", fg = "NONE" })
				hl(0, "SnacksPickerInputBorder", { bg = "NONE", fg = "NONE" })
				hl(0, "SnacksPickerInputSearch", { bg = "NONE", fg = "NONE" })
				hl(0, "SnacksPickerInput", { bg = "NONE" })
			end
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = set_highlights,
			})
			set_highlights()
		end,
	},
}
