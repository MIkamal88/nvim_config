return {
	-- {
	-- 	"David-Kunz/gen.nvim",
	-- 	opts = {
	-- 		model = "deepseek-r1:8b",
	-- 		quit_map = "q",
	-- 		retry_map = "<c-r>",
	-- 		accept_map = "<c-cr>",
	-- 		host = "ollama",
	-- 		port = "11434",
	-- 		display_mode = "float",
	-- 		show_prompt = true,
	-- 		show_model = true,
	-- 		no_auto_close = false,
	-- 		file = false,
	-- 		hidden = false,
	-- 		init = function(options)
	-- 			pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
	-- 		end,
	-- 		command = function(options)
	-- 			local body = { model = options.model, stream = true }
	-- 			return "curl --silent --no-buffer -X POST http://"
	-- 				.. options.host
	-- 				.. ":"
	-- 				.. options.port
	-- 				.. "/api/chat -d $body"
	-- 		end,
	-- 		result_filetype = "markdown",
	-- 		debug = false,
	-- 	},
	-- },
	-- {
	-- 	"milanglacier/minuet-ai.nvim",
	-- 	config = function()
	-- 		-- local vectorcode_cacher = require("vectorcode.cacher")
	-- 		require("minuet").setup({
	-- 			notify = "debug",
	-- 			virtualtext = {
	-- 				auto_trigger_ft = {},
	-- 				keymap = {
	-- 					accept = "<C-e>",
	-- 					accept_line = "<C-q>",
	-- 					accept_n_lines = "<A-z>",
	-- 					prev = "<A-[>",
	-- 					next = "<C-c>",
	-- 					dismiss = "<A-e>",
	-- 				},
	-- 			},
	-- 			provider = "openai_fim_compatible",
	-- 			add_single_line_entry = true,
	-- 			n_completions = 1,
	-- 			context_window = 512,
	-- 			throttle = 400,
	-- 			debounce = 100,
	-- 			after_cursor_filter_length = 30,
	-- 			provider_options = {
	-- 				openai_fim_compatible = {
	-- 					api_key = "TERM",
	-- 					name = "Ollama",
	-- 					stream = true,
	-- 					end_point = "http://ollama:11434/v1/completions",
	-- 					model = "qwen2.5-coder:latest",
	-- 					optional = {
	-- 						max_tokens = 256,
	-- 						top_p = 0.9,
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- codeium
	--  {
	--    "Exafunction/codeium.nvim",
	--    cmd = "Codeium",
	--    event = "InsertEnter",
	--    build = ":Codeium Auth",
	--    opts = {
	--  	enable_cmp_source = false,
	--      virtual_text = {
	--        enabled = true,
	--  		idle_delay = 50,
	--        key_bindings = {
	--          accept = "<C-c>",
	--          next = "<M-]>",
	--          prev = "<M-[>",
	--        },
	--      },
	--    },
	--  },
	-- copilot
	{
		"zbirenbaum/copilot.lua",
		-- enabled = false,
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
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
}
