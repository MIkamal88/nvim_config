return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			local lualine = require("lualine")

			local diagnostics_sources = require("lualine.components.diagnostics.sources").sources

			local confui = require("config.microchad.ui")

			diagnostics_sources.get_diagnostics_in_current_root_dir = confui.get_diagnostics_in_current_root_dir

			lualine.setup({
				options = {
					icons_enabled = true,
					theme = require("config.microchad.lualine_theme").theme,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					always_divide_middle = false,
					disabled_filetypes = {
						winbar = {
							"neo-tree",
							"aerial",
							"NvimTree",
							"starter",
							"Trouble",
							"qf",
							"NeogitStatus",
							"NeogitCommitMessage",
							"NeogitPopup",
						},
						statusline = {
							"starter",
						},
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						"branch",
						confui.project_name,
						confui.get_workspace_diff,
					},
					lualine_c = { { "filename", path = 1, symbols = confui.file_status_symbol }, { "searchcount" } }, -- relative path
					lualine_x = {
						{ "diagnostics", sources = { "get_diagnostics_in_current_root_dir" } },
						confui.encoding,
						confui.fileformat,
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				tabline = {
					lualine_a = {
						{ "filetype", icon_only = true },
					},
					lualine_b = {
						{ "tabs", mode = 2, max_length = vim.o.columns },
						{
							function()
								vim.o.showtabline = 1
								return ""
							end,
						},
					},
				},
				winbar = {
					lualine_a = {
						{ "filetype", icon_only = true },
						{ "filename", path = 0, symbols = confui.file_status_symbol },
					},
					lualine_c = { " " },
					lualine_x = {
						function()
							return " "
						end,
						{ "diagnostics", sources = { "nvim_diagnostic" } },
						"diff",
					},
				},
				inactive_winbar = {
					lualine_a = {
						{ "filetype", icon_only = true },
						{ "filename", path = 0, symbols = confui.file_status_symbol },
					},
					lualine_x = {
						{ "diagnostics", sources = { "nvim_diagnostic" } },
						"diff",
					},
				},
				extensions = { "aerial", "nvim-tree", "quickfix", "toggleterm" },
			})
		end,
	},
}
