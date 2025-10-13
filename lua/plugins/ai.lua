local function load_system_prompt()
	local lines = vim.fn.readfile("/home/m_kamal/.config/nvim/lua/utils/sys_prompt.txt")
	return table.concat(lines, "\n")
end

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
		init = function()
			vim.g.llama_config = {
				endpoint = "http://localhost:11434/infill",
				show_info = false,
				n_prefix = 256,
				n_suffix = 256,
				n_prefict = 30,
				keymap_accept_full = "<C-c>",
				keymap_accept_line = "<C-l>",
				enable_at_startup = false,
			}
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		config = function(_, opts)
			require("codecompanion").setup(opts)
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MeanderingProgrammer/render-markdown.nvim",
			"ravitemer/codecompanion-history.nvim",
		},

		opts = {
			opts = {
				system_prompt = function()
					return load_system_prompt()
				end,
			},
			adapters = {
				llama_cpp = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						name = "llama_cpp",
						formatted_name = "LlamaCPP",
						schema = { model = { cache_prompt = { default = true, mapping = "parameters" } } },
						env = {
							url = "http://localhost:11434",
							api_key = "TERM",
							chat_url = "/v1/chat/completions",
						},
					})
				end,
			},

			strategies = {
				chat = { adapter = "llama_cpp" },
				inline = { adapter = "llama_cpp" },
				cmd = { adapter = "llama_cpp" },
			},

			prompt_library = {
				["JavaScript console"] = {
					strategy = "chat",
					description = "Act as a JavaScript console",
					prompts = {
						{
							role = "system",
							content = "I want you to act as a javascript console. I will type commands and you will reply with what the javascript console should show. I want you to only reply with the terminal output inside one unique code block, and nothing else. do not write explanations. do not type commands unless I instruct you to do so. when I need to tell you something in english, I will do so by putting text inside curly brackets {like this}.",
						},
					},
				},
			},
			extensions = {
				history = {
					enabled = true,
					opts = {
						keymap = "gh",
						save_chat_keymap = "sc",
						auto_save = true,
						expiration_days = 0,
						auto_generate_title = true,
						continue_last_chat = false,
						delete_on_clearing_chat = false,
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
						enable_logging = false,
						max_history = 10,
					},
				},
			},
		},
	},
}
-- Simplify
-- Explain
