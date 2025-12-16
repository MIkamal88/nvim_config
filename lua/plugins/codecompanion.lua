local function load_system_prompt()
	local lines = vim.fn.readfile("/home/m_kamal/.config/nvim/lua/utils/sys_prompt.txt")
	return table.concat(lines, "\n")
end

local function load_prompt_library()
	local path = "/home/m_kamal/.config/nvim/lua/utils/prompts/prompt_library.json"
	local file = io.open(path, "r")
	if not file then
		vim.notify("Could not open " .. path, vim.log.levels.ERROR)
		return {}
	end

	local content = file:read("*a")
	file:close()

	local ok, data = pcall(vim.fn.json_decode, content)
	if not ok then
		vim.notify("Error parsing prompt_library.json", vim.log.levels.ERROR)
		return {}
	end

	return data
end

return {
	"olimorris/codecompanion.nvim",
	version = "v17.33.0",
	config = function(_, opts)
		require("codecompanion").setup(opts)
	end,
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MeanderingProgrammer/render-markdown.nvim",
		{ "ravitemer/codecompanion-history.nvim", commit = "eb99d25" },
		"ravitemer/mcphub.nvim",
	},

	opts = {
		opts = {
			log_level = "DEBUG",
			system_prompt = function()
				return load_system_prompt()
			end,
		},
		adapters = {
			acp = {
				claude_code = function()
					return require("codecompanion.adapters").extend("claude_code", {
						env = {
							CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_API"),
						},
					})
				end,
				gemini_cli = function()
					return require("codecompanion.adapters").extend("gemini_cli", {
						defaults = {
							auth_method = "gemini-api-key",
						},
						env = {
							GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
						},
					})
				end,
			},
			llama_weak = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					name = "llama_weak",
					formatted_name = "LlamaCPP",
					schema = { model = { cache_prompt = { default = true, mapping = "parameters" } } },
					env = {
						url = "http://localhost:11434",
						api_key = "TERM",
						chat_url = "/v1/chat/completions",
					},
				})
			end,
			llama_cpp = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					name = "llama_cpp",
					formatted_name = "LlamaCPP",
					schema = { model = { cache_prompt = { default = true, mapping = "parameters" } } },
					env = {
						url = "http://100.65.247.58:11434",
						api_key = "TERM",
						chat_url = "/v1/chat/completions",
					},
				})
			end,
		},

		strategies = {
			chat = { adapter = "claude_code" },
			inline = { adapter = "claude_code" },
			cmd = { adapter = "llama_weak" },
		},

		prompt_library = load_prompt_library(),

		display = {
			chat = {
				icons = {
					tool_success = "󰸞 ",
				},
				fold_context = true,
			},
		},
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
					show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
					add_mcp_prefix_to_tool_names = false, -- Adds `mcp__` prefix e.g `mcp__github__get_issue`
					show_result_in_chat = true, -- Show tool results directly in chat buffer
					format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
					-- MCP Resources
					make_vars = true, -- Convert MCP resources to #variables for prompts
					-- MCP Prompts
					make_slash_commands = true, -- Add MCP prompts as /slash commands
				},
			},
			history = {
				enabled = true,
				opts = {
					keymap = "gh",
					title_generation_opts = {
						adapter = "llama_weak",
						refresh_every_n_prompts = 3,
					},
					save_chat_keymap = "sc",
					auto_save = true,
					expiration_days = 0,
					auto_generate_title = true,
					continue_last_chat = false,
					delete_on_clearing_chat = true,
					dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
					enable_logging = false,
					max_history = 10,
				},
			},
		},
	},
}
