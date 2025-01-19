vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
-- command to toggle cheatsheet
vim.api.nvim_create_user_command("Cheatsheet", function()
	require("neo-tree.command").execute({ action = "close" })
	require("config.microchad.cheatsheet." .. "grid")()
end, {})
