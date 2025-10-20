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
	config = function(_, opts)
		require("codecompanion").setup(opts)
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MeanderingProgrammer/render-markdown.nvim",
		"ravitemer/codecompanion-history.nvim",
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

		prompt_library = load_prompt_library(),

		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
					show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
					add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
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
