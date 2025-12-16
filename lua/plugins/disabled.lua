local disabled = {
	{ "catppuccin" },
	{ "folke/tokyonight.nvim" },
	{ "akinsho/bufferline.nvim" },
	{ "folke/noice.nvim" },
}

for i, plugin in ipairs(disabled) do
	plugin.enabled = false
end

return {
	disabled,
}
