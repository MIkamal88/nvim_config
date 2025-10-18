return {
	{
		"tpope/vim-dadbod",
		lazy = true,
		cmd = "DBUIToggle",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function(_, opts)
			vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
				},
				command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
					"mysql",
					"plsql",
				},
				callback = function()
					vim.schedule(opts.db_completion)
				end,
			})
		end,
		init = function()
			require("utils.remaps").map_virtual({
				{ "<leader>D", group = "database", icon = { icon = " ", hl = "Constant" } },
				{ "<leader>Dt", group = "toggle dadbod", icon = { icon = " ", hl = "Constant" } },
				{ "<leader>Df", group = "find buffer", icon = { icon = " ", hl = "Constant" } },
				{ "<leader>Dr", group = "rename buffer", icon = { icon = "󰑕 ", hl = "Constant" } },
				{ "<leader>Dq", group = "last query", icon = { icon = " ", hl = "Constant" } },
			})
		end,
		keys = {
			{ "<leader>Dt", "<cmd>DBUIToggle<cr>", desc = "toggle ui" },
			{ "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "find buffer" },
			{ "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc = "rename buffer" },
			{ "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "last query " },
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
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
				enable_tailwind = true,
				custom_colors = {
					{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
					{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
				},
				exclude_filetypes = {},
				exclude_buftypes = {},
				exclude_buffer = function(bufnr) end,
			})
		end,
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	event = "LspAttach",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"neovim/nvim-lspconfig",
	-- 		{
	-- 			"saghen/blink.cmp",
	-- 			-- Ensure blink.cmp is loaded before typescript-tools
	-- 			lazy = false,
	-- 			priority = 1000,
	-- 		},
	-- 	},
	-- },

	{
		"razak17/tailwind-fold.nvim",
		event = "LspAttach",
		opts = {
			min_chars = 50,
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
	},

	{
		"MaximilianLloyd/tw-values.nvim",
		event = "LspAttach",
		keys = {
			{ "<Leader>cv", "<CMD>TWValues<CR>", desc = "Tailwind CSS values" },
		},
		opts = {
			border = "single",
			show_unknown_classes = true,
		},
	},

	{
		"axelvc/template-string.nvim",
		event = "InsertEnter",
		ft = {
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		},
		config = true,
	},

	-- {
	-- 	"dmmulroy/tsc.nvim",
	-- 	event = "LspAttach",
	-- 	cmd = { "TSC" },
	-- 	config = true,
	-- },

	-- {
	-- 	"dmmulroy/ts-error-translator.nvim",
	-- 	event = "LspAttach",
	-- 	config = true,
	-- },
	{
		"hat0uma/csvview.nvim",
		event = "LspAttach",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
			view = {
				display_mode = "border",
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},
}
