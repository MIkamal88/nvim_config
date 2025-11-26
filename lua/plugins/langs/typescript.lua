return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				vtsls = {
					init_options = {
						preferences = {
							disableSuggestions = true,
						},
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"javascript",
				"jsdoc",
			},
		},
	},
	{
		"axelvc/template-string.nvim",
		event = "InsertEnter",
		ft = {
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		},
		config = true,
	},
	{
		"dmmulroy/tsc.nvim",
		opts = {
			auto_start_watch_mode = false,
			use_trouble_qflist = true,
			flags = {
				watch = false,
			},
		},
		keys = {
			{ "<leader>ct", ft = { "typescript", "typescriptreact" }, "<cmd>TSC<cr>", desc = "Type Check" },
			{
				"<leader>xy",
				ft = { "typescript", "typescriptreact" },
				"<cmd>TSCOpen<cr>",
				desc = "Type Check Quickfix",
			},
		},
		ft = {
			"typescript",
			"typescriptreact",
		},
		cmd = {
			"TSC",
			"TSCOpen",
			"TSCClose",
			"TSStop",
		},
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		opts = {
			servers = { "vtsls" }, -- Specify which servers to translate
		},
	},
	-- {
	--   "nvim-neotest/neotest",
	--   optional = true,
	--   dependencies = {
	--     "nvim-neotest/neotest-jest",
	--     "adrigzr/neotest-mocha",
	--     "marilari88/neotest-vitest",
	--   },
	--   opts = {
	--     adapters = {
	--       ["neotest-jest"] = {
	--         jestCommand = "npm test --",
	--         jestConfigFile = "custom.jest.config.ts",
	--         env = { CI = true },
	--         cwd = function()
	--           return vim.fn.getcwd()
	--         end,
	--       },
	--       ["neotest-mocha"] = {
	--         command = "npm test --",
	--         env = { CI = true },
	--         cwd = function()
	--           return vim.fn.getcwd()
	--         end,
	--       },
	--       ["neotest-vitest"] = {},
	--     },
	--   },
	--   -- stylua: ignore
	--   keys = {
	--     { "<leader>tw", function() require('neotest').run.run({ jestCommand = 'jest --watch ' }) end, desc = "Run Watch" },
	--   },
	-- },
}
