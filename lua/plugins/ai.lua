return {
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	build = ":Copilot auth",
	-- 	event = "BufEnter",
	-- 	opts = {
	-- 		suggestion = {
	-- 			enabled = true,
	-- 			auto_trigger = true,
	-- 			keymap = {
	-- 				accept = "<C-c>",
	-- 				next = "<M-e>",
	-- 				prev = "<M-q>",
	-- 			},
	-- 		},
	-- 		panel = { enabled = false },
	-- 	},
	-- },
	-- { "AndreM222/copilot-lualine" },
	{
		"yetone/avante.nvim",
		event = "InsertEnter",
		version = false,
		opts = {
			provider = "ollama",
			auto_suggestions_provider = "ollama",
			ollama = {
				endpoint = "http://127.0.0.1:11434",
				model = "qwen2.5-coder:7b",
			},
			use_absolute_path = true,
			behaviour = {
				auto_suggestions = false,
				auto_set_highlight_group = true,
			},
			mappings = {
				suggestion = {
					accept = "<C-c>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	},
}
