local uv = vim.uv or vim.loop
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
keymap({ "n", "v", "t" }, "<C-`>", "<Cmd>FloatermToggle<CR>", opts)
keymap({ "n", "v" }, "<leader>ac", "<Cmd>CodeCompanionChat Toggle<CR>", opts)
keymap("n", "<leader>at", "<Cmd>LlamaToggle<CR>", { desc = "Toggle AI completion" })

local esc_timer
local function toggle_esc()
  -- Lazily create the timer, but guard against failure
  if not esc_timer then
    esc_timer = uv and uv.new_timer()
    if not esc_timer then
      return
    end
  end

  -- If the timer is already running, stop it and leave insert mode
  if esc_timer and esc_timer:is_active() then
    esc_timer:stop()
    vim.cmd("stopinsert")
  else
    -- Otherwise start the timer to wait for a second <Esc>
    esc_timer:start(200, 0, function() end)
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
      "t",
      false
    )
  end
end
keymap("t", "<Esc>", toggle_esc, { desc = "Double <Esc> to normal mode" })

