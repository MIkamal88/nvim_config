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
		"ggml-org/llama.vim",
		commit = "a49449cf",
		init = function()
			vim.g.llama_config = {
				endpoint = "http://localhost:11434/infill",
				show_info = false,
				keymap_accept_full = "<C-c>",
			}
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		opts = {
			adapters = {
				llama_cpp = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						name = "llama_cpp",
						formatted_name = "LlamaCPP",
						schema = {
							model = {
								default = "qwen-2.5.1-coder-7b",
							},
						},
						env = {
							url = "http://localhost:11434",
							api_key = "TERM",
						},
						handlers = {
							inline_output = function(self, data)
								local openai = require("codecompanion.adapters.openai")
								return openai.handlers.inline_output(self, data)
							end,
							chat_output = function(self, data)
								local openai = require("codecompanion.adapters.openai")
								local result = openai.handlers.chat_output(self, data)
								if result ~= nil then
									result.output.role = "assistant"
								end
								return result
							end,
						},
					})
				end,
			},
			strategies = {
				chat = {
					adapter = "llama_cpp",
				},
				inline = {
					adapter = "llama_cpp",
				},
				cmd = {
					adapter = "llama_cpp",
				},
			},
			extensions = {
				history = {
					enabled = true,
					opts = {
						keymap = "gh",
						save_chat_keymap = "sc",
						auto_save = true,
						-- Number of days after which chats are automatically deleted (0 to disable)
						expiration_days = 0,
						picker = "telescope",
						auto_generate_title = true,
						continue_last_chat = false,
						delete_on_clearing_chat = false,
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
						enable_logging = false,
					},
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/codecompanion-history.nvim",
		},
	},
}
