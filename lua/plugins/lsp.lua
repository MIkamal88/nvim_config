return {
	{
		"folke/noice.nvim",
		opts = {
			presets = {
				lsp_doc_border = true,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = true },
			servers = {
				lua_ls = require("plugins.lsp.lua_ls"),
				pyright = require("plugins.lsp.pyright")
			},
			setup = {},
		},
	},
}
