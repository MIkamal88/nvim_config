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
	"catgoose/nvim-colorizer.lua",
	ft = { "css", "html", "javascript", "typescript", "lua", "json" },
	opts = {
		lazy_load = true,
		filetypes = {
			"*",
			noice = { always_update = true },
			blink_menu = { always_update = true },
			blink_docs = { always_update = true },
			cmp_menu = { always_update = true },
			cmp_docs = { always_update = true },
		},
		buftypes = {
			-- exclude prompt and popup buftypes from highlight
			"!prompt",
			"!popup",
		},
		user_default_options = {
			tailwind = true,
			tailwind_opts = { -- Options for highlighting tailwind names
				update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
			},
			names_opts = { -- options for mutating/filtering names.
				lowercase = false, -- name:lower(), highlight `blue` and `red`
				camelcase = false, -- name, highlight `Blue` and `Red`
				uppercase = false, -- name:upper(), highlight `BLUE` and `RED`
				strip_digits = true, -- ignore names with digits,
				-- highlight `blue` and `red`, but not `blue3` and `red4`
			},
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			RGB = false, -- #RGB hex codes
			RGBA = false,
		},
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
