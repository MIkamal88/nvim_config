return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "BufEnter",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-c>",
					next = "<M-e>",
					prev = "<M-q>",
				},
			},
			panel = { enabled = false },
		},
	},
	{ "AndreM222/copilot-lualine" },
}
