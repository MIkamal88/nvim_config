vim.api.nvim_create_user_command("AttachOrReloadColors", function()
	if package.loaded["colorizer"] then
		require("colorizer").reload_all_buffers()
	end
	require("colorizer").attach_to_buffer(0)
end, { nargs = 0 })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "csv",
	desc = "Enable CSV View on .csv files",
	callback = function()
		require("csvview").enable()
	end,
})

return {
	{
		"barrett-ruth/live-server.nvim",
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true,
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
	{
		"pmizio/typescript-tools.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			{
				"saghen/blink.cmp",
				-- Ensure blink.cmp is loaded before typescript-tools
				lazy = false,
				priority = 1000,
			},
		},
	},

	{
		"razak17/tailwind-fold.nvim",
		opts = {
			min_chars = 50,
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
	},

	{
		"MaximilianLloyd/tw-values.nvim",
		keys = {
			{ "<Leader>cv", "<CMD>TWValues<CR>", desc = "Tailwind CSS values" },
		},
		opts = {
			-- border = EcoVim.ui.float.border or "rounded", -- Valid window border style,
			show_unknown_classes = true, -- Shows the unknown classes popup
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
		config = true, -- run require("template-string").setup()
	},

	{
		"dmmulroy/tsc.nvim",
		cmd = { "TSC" },
		config = true,
	},

	{
		"dmmulroy/ts-error-translator.nvim",
		config = true,
	},
	{
		"hat0uma/csvview.nvim",
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
