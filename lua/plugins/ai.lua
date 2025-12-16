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
	-- {
	-- 	"ggml-org/llama.vim",
	-- 	init = function()
	-- 		vim.g.llama_config = {
	-- 			endpoint = "http://100.65.247.58:11434/infill",
	-- 			show_info = false,
	-- 			n_prefix = 256,
	-- 			n_suffix = 256,
	-- 			n_prefict = 30,
	-- 			keymap_accept_full = "<C-c>",
	-- 			keymap_accept_line = "<C-l>",
	-- 			enable_at_startup = true,
	-- 		}
	-- 	end,
	-- },

	{
		"milanglacier/minuet-ai.nvim",
		config = function()
			require("minuet").setup({
				provider = "openai_fim_compatible",
				n_completions = 1,
				context_window = 8192,
				provider_options = {
					openai_fim_compatible = {
						api_key = "TERM",
						name = "Llama.cpp",
						end_point = "http://100.65.247.58:11434/v1/completions",
						model = "Qwen3:Coder",
						optional = {
							max_tokens = 56,
							top_p = 0.9,
						},
						-- llama.cpp doesn't support suffix option in FIM completion
						-- so we embed FIM tokens directly in the prompt
						template = {
							prompt = function(context_before_cursor, context_after_cursor, _)
								return "<|fim_prefix|>"
									.. context_before_cursor
									.. "<|fim_suffix|>"
									.. context_after_cursor
									.. "<|fim_middle|>"
							end,
							suffix = false,
						},
					},
				},
				virtualtext = {
					auto_trigger_ft = { }, -- auto-trigger for all filetypes
					keymap = {
						accept = "<C-c>",
						accept_line = "<C-l>",
						prev = "<A-[>",
						next = "<A-]>",
						dismiss = "<C-e>",
					},
				},
			})
		end,
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		commit = "8ff40b5",
		build = "npm install -g mcp-hub@latest",
		config = function()
			require("mcphub").setup({
				config = vim.fn.expand("~/.config/mcphub/servers.json"),
				port = 37373,
				shutdown_delay = 5 * 60 * 000,
				use_bundled_binary = false,
				mcp_request_timeout = 60000,
				global_env = {}, -- Global environment variables available to all MCP servers
				workspace = {
					enabled = true,
					look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
					reload_on_dir_changed = true,
					port_range = { min = 40000, max = 41000 }, -- Port range for generating unique workspace ports
					get_port = nil, -- Optional function returning custom port number. Called when generating ports to allow custom port assignment logic
				},

				auto_approve = false, -- Auto approve mcp tool calls
				auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically

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
	-- {
	-- 	"NickvanDyke/opencode.nvim",
	-- 	dependencies = {
	-- 		-- Recommended for `ask()` and `select()`.
	-- 		-- Required for `snacks` provider.
	-- 		---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
	-- 		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	-- 	},
	-- 	config = function()
	-- 		---@type opencode.Opts
	-- 		vim.g.opencode_opts = {
	-- 			-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
	-- 		}
	--
	-- 		-- Required for `opts.events.reload`.
	-- 		vim.o.autoread = true
	--
	-- 		-- Recommended/example keymaps.
	-- 		vim.keymap.set({ "n", "x" }, "<C-q>", function()
	-- 			require("opencode").ask("@this: ", { submit = true })
	-- 		end, { desc = "Ask opencode" })
	-- 		-- vim.keymap.set({ "n", "x" }, "<C-x>", function()
	-- 		-- 	require("opencode").select()
	-- 		-- end, { desc = "Execute opencode action…" })
	-- 		-- vim.keymap.set({ "n", "x" }, "ga", function()
	-- 		-- 	require("opencode").prompt("@this")
	-- 		-- end, { desc = "Add to opencode" })
	-- 		-- vim.keymap.set({ "n", "t" }, "<C-.>", function()
	-- 		-- 	require("opencode").toggle()
	-- 		-- end, { desc = "Toggle opencode" })
	-- 		-- vim.keymap.set("n", "<S-C-u>", function()
	-- 		-- 	require("opencode").command("session.half.page.up")
	-- 		-- end, { desc = "opencode half page up" })
	-- 		-- vim.keymap.set("n", "<S-C-d>", function()
	-- 		-- 	require("opencode").command("session.half.page.down")
	-- 		-- end, { desc = "opencode half page down" })
	-- 		-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
	-- 		-- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
	-- 		-- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
	-- 	end,
	-- },
}
