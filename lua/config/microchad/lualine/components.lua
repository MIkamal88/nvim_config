local config = require("config.microchad.lualine.config").options
local icons = require("config.icons")

local M = {}

local hl_str = function(str, hl_cur, hl_after)
	if hl_after == nil then
		return "%#" .. hl_cur .. "#" .. str .. "%*"
	end
	return "%#" .. hl_cur .. "#" .. str .. "%*" .. "%#" .. hl_after .. "#"
end

local function truncate(text, min_width)
	if string.len(text) > min_width then
		return string.sub(text, 1, min_width) .. "…"
	end
	return text
end

local prev_branch = ""
M.branch = {
	"branch",
	icons_enabled = false,
	icon = hl_str("", "SLGitIcon", "SLBranchName"),
	colored = false,
	fmt = function(str)
		if vim.bo.filetype == "toggleterm" then
			str = prev_branch
		elseif str == "" or str == nil then
			str = "!=vcs"
		end
		prev_branch = str
		local icon = hl_str("  ", "SLGitIcon", "SLBranchName")
		return hl_str(config.separator_icon.left, "SLSeparator")
			.. hl_str(icon, "SLGitIcon")
			.. hl_str(truncate(str, 10), "SLBranchName")
			.. hl_str(config.separator_icon.right, "SLSeparator", "SLSeparator")
	end,
}

M.position = function()
	local current_line = vim.fn.line(".")
	local current_column = vim.fn.col(".")
	local left_sep = hl_str(config.separator_icon.left, "SLSeparator")
	local right_sep = hl_str(config.separator_icon.right, "SLSeparator", "SLSeparator")
	local str = "Ln " .. current_line .. ", Col " .. current_column
	return left_sep .. hl_str(str, "SLPosition", "SLPosition") .. right_sep
end

M.diagnostics = function()
	local function nvim_diagnostic()
		local diagnostics = vim.diagnostic.get(0)
		local count = { 0, 0, 0, 0 }
		for _, diagnostic in ipairs(diagnostics) do
			count[diagnostic.severity] = count[diagnostic.severity] + 1
		end
		return count[vim.diagnostic.severity.ERROR],
			count[vim.diagnostic.severity.WARN],
			count[vim.diagnostic.severity.INFO],
			count[vim.diagnostic.severity.HINT]
	end

	local error_count, warn_count, info_count, hint_count = nvim_diagnostic()
	local error_hl = hl_str(icons.diagnostics.error .. " " .. error_count, "SLError", "SLError")
	local warn_hl = hl_str(icons.diagnostics.warn .. " " .. warn_count, "SLWarning", "SLWarning")
	local hint_hl = hl_str(icons.diagnostics.hint .. " " .. hint_count, "SLInfo", "SLInfo")
	local left_sep = hl_str(config.thin_separator_icon.left, "SLSeparator")
	local right_sep = hl_str(config.thin_separator_icon.right, "SLSeparator", "SLSeparator")
	return left_sep .. error_hl .. " " .. warn_hl .. " " .. hint_hl .. right_sep
end

M.mode = {
	"mode",
	fmt = function(str)
		local left_sep = hl_str(config.separator_icon.left, "SLSeparator", "SLPadding")
		local right_sep = hl_str(config.separator_icon.right, "SLSeparator", "SLPadding")
		return left_sep .. hl_str(str, "SLMode") .. right_sep
	end,
}

return M
