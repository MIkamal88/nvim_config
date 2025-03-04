return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		event = "InsertEnter",
		config = function()
			local types = require("luasnip.util.types")

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").setup({
				history = true,
				delete_check_events = "TextChanged",
				-- Display a cursor-like placeholder in unvisited nodes
				-- of the snippet.
				ext_opts = {
					[types.insertNode] = {
						unvisited = {
							virt_text = { { "|", "Conceal" } },
							virt_text_pos = "inline",
						},
					},
				},
			})
		end,
	},
	{
		"saghen/blink.cmp",
		---@class PluginLspOpts
		opts = {
			enabled = function()
				return not vim.list_contains({ "lazy" }, vim.bo.filetype)
					and vim.bo.buftype ~= "prompt"
					and vim.b.completion ~= false
			end,
			keymap = {
				preset = "default",
				["<Enter>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
			},
		},
	},
}
