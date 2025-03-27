return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "VeryLazy" },
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 300,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		},
	},
	{
		"LazyVim/LazyVim",
		opts = { colorscheme = "rxyhn" },
	},
	{
		"notken12/base46-colors",
		config = function()
			local c = require("rxyhn.palette")
			c.base08 = "#f26e74"
			local hl = vim.api.nvim_set_hl
			local function set_highlights()
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
				hl(0, "GitSignsCurrentLineBlame", { fg = "#061115" })
				hl(0, "String", { fg = "#82c29c", bg = "NONE" })
				hl(0, "IblScope", { fg = c.base0E, bg = "NONE" })
				hl(0, "guibg", { fg = "NONE", bg = "NONE" })
				hl(0, "Normal", { fg = "NONE", bg = "NONE" })
				hl(0, "NormalFloat", { fg = "NONE", bg = "NONE" })
				hl(0, "MsgArea", { fg = "NONE", bg = "NONE" })
				hl(0, "NormalNC", { fg = "NONE", bg = "NONE" })
			end
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = set_highlights,
			})
			set_highlights()
		end,
	},
}
