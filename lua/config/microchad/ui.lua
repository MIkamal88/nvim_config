local M = {}

local autocmd = vim.api.nvim_create_autocmd
local my_augroup = require("config.microchad.builtin_extend").my_augroup

local git_workspace_diff_setup = function()
	local function is_a_git_dir()
		local is_git = vim.fs.root(vim.fn.getcwd(), ".git")
		return is_git
	end

	local function compute_workspace_diff(cwd)
		vim.system({ "git", "diff", "--stat" }, { text = true }, function(obj)
			local stdout = vim.split(obj.stdout, "\n")
			if #stdout < 2 then
				return
			end

			-- get the second last line containing the stats
			local changes_raw = stdout[#stdout - 1]

			local changes_table = vim.split(changes_raw, ",")

			local changes = ""

			for _, i in pairs(changes_table) do
				if i:find("change") then
					changes = changes .. " " .. i:match("(%d+)")
				elseif i:find("insertion") then
					changes = changes .. " +" .. i:match("(%d+)")
				elseif i:find("deletion") then
					changes = changes .. " -" .. i:match("(%d+)")
				end
			end

			if changes ~= "" then
				changes = " " .. changes
			end

			M.git_workspace_diff[cwd] = changes
		end)
	end

	local function init_workspace_diff()
		local cwd = vim.fn.getcwd()

		if M.git_workspace_diff[cwd] == nil and is_a_git_dir() then
			compute_workspace_diff(cwd)
		end
	end

	local function update_workspace_diff()
		local cwd = vim.fn.getcwd()
		if M.git_workspace_diff[cwd] ~= nil then
			compute_workspace_diff(cwd)
		end
	end

	autocmd("BufEnter", {
		group = my_augroup,
		desc = "Init the git diff",
		callback = function()
			vim.defer_fn(function()
				init_workspace_diff()
				-- defer this function because project root need to be updated.
			end, 100)
		end,
	})
	autocmd("BufWritePost", {
		group = my_augroup,
		desc = "Update the git diff",
		callback = function()
			vim.defer_fn(function()
				update_workspace_diff()
			end, 100)
		end,
	})
end

M.get_workspace_diff = function()
	local cwd = vim.fn.getcwd()
	-- don't use pattern matching
	if vim.fn.expand("%:p:h"):find(cwd, nil, true) then
		-- if the absolute path of current file excluding the file name is a sub directory of cwd
		return M.git_workspace_diff[cwd] or ""
	else
		return ""
	end
end

M.encoding = function()
	local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
	return ret
end

M.fileformat = function()
	local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
	if ret == "dos" then
		ret = ""
	end
	return ret
end

-- current file is lua/conf/ui.lua
-- current working directory is ~/.config/nvim
-- this function will return "nvim"
--
---@return string project_name
M.project_name = function()
	-- don't use pattern matching, just plain match
	if vim.fn.expand("%:p:h"):find(vim.fn.getcwd(), nil, true) then
		-- if the absolute path of current file is a sub directory of cwd
		return " " .. vim.fn.fnamemodify("%", ":p:h:t")
	else
		return ""
	end
end

M.file_status_symbol = {
	modified = "",
	readonly = "",
	new = "",
	unnamed = "󰽤",
}

M.get_diagnostics_in_current_root_dir = function()
	local buffers = vim.api.nvim_list_bufs()
	local severity = vim.diagnostic.severity
	---@diagnostic disable-next-line: undefined-field
	local cwd = vim.uv.cwd()

	local function dir_is_parent_of_buf(buf, dir)
		local filename = vim.api.nvim_buf_get_name(buf)
		if vim.fn.filereadable(filename) == 0 then
			return false
		end

		-- expand to full path name and remove the last component
		return vim.fn.fnamemodify(filename, ":p:h"):find(dir, nil, true) and true or false
	end
	local function get_num_of_diags_in_buf(severity_level, buf)
		local count = vim.diagnostic.get(buf, { severity = severity_level })
		return vim.tbl_count(count)
	end

	local n_diagnostics = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

	for _, buf in ipairs(buffers) do
		if dir_is_parent_of_buf(buf, cwd) then
			for _, level in ipairs({ "ERROR", "WARN", "INFO", "HINT" }) do
				n_diagnostics[level] = n_diagnostics[level] + get_num_of_diags_in_buf(severity[level], buf)
			end
		end
	end

	return n_diagnostics.ERROR, n_diagnostics.WARN, n_diagnostics.INFO, n_diagnostics.HINT
end

M.git_workspace_diff = {}

M.reopen_qflist_by_trouble = function()
	local windows = vim.api.nvim_list_wins()

	for _, winid in ipairs(windows) do
		local bufid = vim.api.nvim_win_get_buf(winid)
		local buf_filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
		if buf_filetype == "qf" then
			vim.api.nvim_win_close(winid, true)
		end
	end
	require("trouble").toggle("quickfix")
end

git_workspace_diff_setup()

-- Define spinner frames and state
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_index = 1
local spinner_active = false

-- Timer setup
local uv = vim.uv or vim.loop
local spinner_timer = uv.new_timer()

-- Lualine Spinner component
M.codecompanion_spinner = function()
  if spinner_active then
    return spinner_frames[spinner_index] .. " 󰚩 "
  else
    return " 󰡖 "
  end
end

-- Register autocommands for CodeCompanion
vim.api.nvim_create_autocmd("User", {
  desc = "CodeCompanion spinner start",
  pattern = "CodeCompanionRequestStarted",
  callback = function()
    if spinner_active then return end  -- already running
    spinner_active = true
    spinner_index = 1
    spinner_timer:start(0, 100, vim.schedule_wrap(function()
      spinner_index = (spinner_index % #spinner_frames) + 1
      vim.cmd("redrawstatus") -- refresh lualine
    end))
  end,
})

vim.api.nvim_create_autocmd("User", {
  desc = "CodeCompanion spinner stop",
  pattern = "CodeCompanionRequestFinished",
  callback = function()
    if not spinner_active then return end
    spinner_active = false
    spinner_timer:stop()
    spinner_index = 1
    vim.cmd("redrawstatus")
  end,
})

return M
