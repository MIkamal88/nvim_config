return {
	{
  "luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig",
		},
		ft = { "html", "svelte", "astro", "vue", "typescriptreact", "javascriptreact" },
		opts = {
			document_color = {
				enabled = true,
				kind = "background", -- "inline" | "foreground" | "background"
				inline_symbol = "󰝤 ", -- symbol to show for inline color
				debounce = 200, -- debounce time in ms (increase if still laggy)
			},
			conceal = {
				enabled = true, -- you already have tailwind-fold
			},
		},
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
}
