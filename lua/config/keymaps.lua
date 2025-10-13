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

keymap({ "n", "v" }, "<leader>.", "<Cmd>LiveServerToggle<CR>", { desc = "Toggle LiveServer" })

keymap({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", opts)
keymap({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", opts)

keymap({ "n", "v", "t" }, "<C-`>", "<cmd>FloatermToggle<cr>", opts)

local esc_timer = (vim.uv or vim.loop).new_timer()
keymap("t", "<Esc>", function()
	if esc_timer:is_active() then
		esc_timer:stop()
		vim.cmd("stopinsert")
	else
		esc_timer:start(200, 0, function() end)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "t", false)
	end
end, { expr = false, desc = "Double escape to normal mode" })

keymap("n", "<leader>at", "LlamaToggle", { desc = "Toggle AI completion" })
