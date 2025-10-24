return {
	{
		"folke/noice.nvim",
		opts = {
			cmdline = { view = "cmdline" },
			presets = {
				lsp_doc_border = true,
			},
			notify = {
				format = "popup"
			},
			views = {
				mini = {
					border = {
						style = "single",
					},
				},
				hover = {
					border = {
						style = "single",
					},
				},
				confirm = {
					border = {
						style = "single",
					},
				},
				popup = {
					border = {
						style = "single",
					},
				},
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
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
}
