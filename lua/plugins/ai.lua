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
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
		config = function()
			require("mcphub").setup({
				--- `mcp-hub` binary related options-------------------
				config = vim.fn.expand("~/.config/mcphub/servers.json"),
				port = 37373,
				shutdown_delay = 5 * 60 * 000,
				use_bundled_binary = false,
				mcp_request_timeout = 60000,
				global_env = {}, -- Global environment variables available to all MCP servers (can be a table or a function returning a table)
				workspace = {
					enabled = true,
					look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" }, -- Files to look for when detecting project boundaries (VS Code format supported)
					reload_on_dir_changed = true,
					port_range = { min = 40000, max = 41000 }, -- Port range for generating unique workspace ports
					get_port = nil, -- Optional function returning custom port number. Called when generating ports to allow custom port assignment logic
				},

				---Chat-plugin related options-----------------
				auto_approve = false, -- Auto approve mcp tool calls
				auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically

				--- Plugin specific options-------------------
				native_servers = {}, -- add your custom lua native servers here
				builtin_tools = {
					edit_file = {
						parser = {
							track_issues = true,
							extract_inline_content = true,
						},
						locator = {
							fuzzy_threshold = 0.8,
							enable_fuzzy_matching = true,
						},
						ui = {
							go_to_origin_on_complete = true,
							keybindings = {
								accept = ".",
								reject = ",",
								next = "n",
								prev = "p",
								accept_all = "ga",
								reject_all = "gr",
							},
						},
					},
				},
				ui = {
					window = {
						width = 0.8,
						height = 0.8,
						border = "single",
					},
				},
			})
		end,
	},
}
