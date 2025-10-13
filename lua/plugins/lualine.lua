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
					lualine_x = {
						confui.codecompanion_spinner,
						confui.encoding,
						confui.fileformat,
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				winbar = {
					lualine_a = {
						{ "filetype", icon_only = true },
						{ "filename", path = 1, symbols = confui.file_status_symbol },
						{ "searchcount" },
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
						{ "filename", path = 1, symbols = confui.file_status_symbol },
					},
				},
				extensions = { "aerial", "nvim-tree", "quickfix", "toggleterm" },
			})
		end,
	},
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	-- cond = false,
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	-- event = "VimEnter",
	-- 	keys = {
	-- 		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
	-- 		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
	-- 		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
	-- 		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
	-- 		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
	-- 		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
	-- 	},
	-- 	opts = function()
	-- 		local bufferline = require("bufferline")
	-- 		local fill_hl = "StatusLine"
	-- 		local custom_bg = { attribute = "bg", highlight = fill_hl }
	-- 		return {
	-- 			highlights = {
	-- 				fill = { bg = custom_bg },
	-- 				buffer_selected = {
	-- 					fg = "#7aa2f7",
	-- 				},
	-- 				background = { bg = custom_bg },
	-- 				close_button = { bg = custom_bg },
	-- 				offset_separator = { bg = custom_bg },
	-- 				trunc_marker = { bg = custom_bg },
	-- 				duplicate = { bg = custom_bg },
	-- 				close_button_selected = { fg = "#B55A67" },
	-- 				separator = { fg = custom_bg, bg = custom_bg },
	-- 				modified = { fg = "#B55A67", bg = custom_bg },
	-- 				hint = { bg = custom_bg },
	-- 				hint_diagnostic = { bg = custom_bg },
	-- 				info = { bg = custom_bg },
	-- 				info_diagnostic = { bg = custom_bg },
	-- 				warning = { bg = custom_bg },
	-- 				warning_diagnostic = { bg = custom_bg },
	-- 				error = { bg = custom_bg },
	-- 				error_diagnostic = { bg = custom_bg },
	-- 			},
	-- 			options = {
	-- 				show_buffer_close_icons = false,
	-- 				show_buffer_icons = false, -- disable filetype icons for buffers
	-- 				show_close_icon = true,
	-- 				show_tab_indicators = false,
	-- 				buffer_close_icon = "",
	-- 				modified_icon = "",
	-- 				diagnostics = "nvim_lsp",
	-- 				always_show_bufferline = true,
	-- 				indicator = {
	-- 					icon = "▎", -- this should be omitted if indicator style is not 'icon'
	-- 					-- style = "none", -- "icon" | "underline" | "none",
	-- 				},
	-- 				separator_style = { " ", " " },
	-- 				diagnostics_indicator = function(_, _, diag)
	-- 					local icons = require("utils.icons").diagnostic_icons
	-- 					local ret = (diag.error and icons.Error .. diag.error .. "" or "")
	-- 						.. (diag.warning and icons.Warn .. diag.warning .. "" or "")
	-- 						.. (diag.info and icons.Info .. diag.info .. "" or "")
	-- 						.. (diag.hint and icons.Hint .. diag.hint or "")
	-- 					return vim.trim(ret)
	-- 				end,
	-- 				offsets = {
	-- 					{
	-- 						filetype = "neo-tree",
	-- 						text = "File Explorer",
	-- 						highlight = "BufferLineBackground",
	-- 						separator = true,
	-- 						-- highlight = "NeoTreeNormal",
	-- 						text_align = "center",
	-- 					},
	-- 				},
	-- 				style_preset = {
	-- 					bufferline.style_preset.no_italic,
	-- 					bufferline.style_preset.no_bold,
	-- 				},
	-- 			},
	-- 		}
	-- 	end,
	-- },
}
