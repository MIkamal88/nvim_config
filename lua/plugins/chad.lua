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
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = function()
			return {
				separator = "bubble", -- bubble | triangle
				---@type any
				colorful = true,
			}
		end,
		config = function(_, opts)
			local lualine_config = require("config.microchad.lualine")
			lualine_config.setup(opts)
			lualine_config.load()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				indicator = {
					style = "underline",
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "center",
						separator = true,
					},
				},
			},
			highlights = {
				separator = {
					bg = "NONE",
					fg = "NONE",
				},
				offset_separator = {
					bg = "NONE",
					fg = "NONE",
				},
			},
		},
		config = function(_, opts)
			-- CheatSheet
			require("config.microchad")
			require("bufferline").setup(opts)
			vim.api.nvim_create_autocmd("BufAdd", {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},
	-- {
	-- 	"nvzone/typr",
	-- 	cmd = "TyprStats",
	-- 	dependencies = "nvzone/volt",
	-- 	opts = {},
	-- },
}
