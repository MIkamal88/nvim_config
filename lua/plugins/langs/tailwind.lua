return {
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
		"razak17/tailwind-fold.nvim",
		event = "LspAttach",
		opts = {
			min_chars = 50,
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
	},
  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = {
      ensure_installed = {
        "tailwindcss",
      },
    },
  },
}
