local M = {}

M.theme = function()
	local colors = {
		innerbg = nil,
		azbg = "#393836",
		bybg = "#201d1d",
		gray = "#b4b3a7",
		color9 = "#3e445e",
		color10 = "#0f1117",
	}

	return {
		inactive = {
			a = { fg = colors.gray, bg = colors.color10, gui = "bold" },
			b = { fg = colors.color9, bg = colors.color10 },
			c = { fg = colors.color9, bg = colors.color10 },
		},
		visual = {
			a = { fg = colors.gray, bg = colors.azbg, bold = true },
			b = { fg = colors.gray, bg = colors.bybg },
			c = { fg = colors.gray, bg = colors.bybg },
		},
		replace = {
			a = { fg = colors.gray, bg = colors.azbg, bold = true },
			b = { fg = colors.gray, bg = colors.bybg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		normal = {
			a = { fg = colors.gray, bg = colors.azbg, bold = true },
			b = { fg = colors.gray, bg = colors.bybg },
			c = { fg = colors.gray, bg = colors.bybg },
		},
		insert = {
			a = { fg = colors.gray, bg = colors.azbg, bold = true },
			b = { fg = colors.gray, bg = colors.bybg },
			c = { fg = colors.gray, bg = colors.bybg },
		},
		command = {
			a = { fg = colors.gray, bg = colors.azbg, bold = true },
			b = { fg = colors.gray, bg = colors.bybg },
			c = { fg = colors.gray, bg = colors.bybg },
		},
	}
end
return M
