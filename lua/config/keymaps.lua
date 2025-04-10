-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)
keymap("x", "p", [["_dP]])
keymap("n", "q:", ":q<cr>")

-- Navigation in Insert mode
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)

-- Indent in Visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap({ "n", "v" }, "<leader>L", "<Cmd>LiveServerStart<CR>", { desc = "Start LiveServer" })
keymap({ "n", "v" }, "<leader>S", "<Cmd>LiveServerStop<CR>", { desc = "Stop LiveServer" })

keymap("n", "<leader>uH", function()
	local attached = require("colorizer").is_buffer_attached()
	if not attached then
		require("colorizer").attach_to_buffer(0)
		vim.notify("Enabled **Colorizer Highlights**", vim.log.levels.INFO, { title = "Tabs" })
	else
		require("colorizer").detach_from_buffer(0)
		vim.notify("Disabled **Colorizer Highlights**", vim.log.levels.WARN, { title = "Tabs" })
	end
end, { desc = "Toggle Colorizer" })
