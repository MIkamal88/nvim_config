local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

-- Helper: center search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Search and tag navigation
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Preserve paste register in visual mode
keymap("x", "p", [["_dP]])

-- Quit command with a description
keymap("n", "q:", "<Cmd>q<CR>", { desc = "Quit current window" })

-- Insert‑mode cursor movement
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<C-o>k", opts)
keymap("i", "<C-l>", "<Right>", opts)

-- Leader‑based commands
keymap({ "n", "v" }, "<C-a>", "<Cmd>CodeCompanionActions<CR>", opts)

keymap({ "n", "t" }, "<c-`>", function()
	Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

keymap({ "n", "v" }, "<leader>ac", "<Cmd>CodeCompanionChat Toggle<CR>", opts)

keymap({ "n", "v" }, "<leader>gD", "<Cmd>CodeDiff<CR>", opts)

keymap("n", "<leader>at", "<Cmd>LlamaToggle<CR>", { desc = "Toggle AI completion" })
