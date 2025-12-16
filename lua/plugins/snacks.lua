return {
	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					header = [[
                 ▄ ▄                   
             ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     
             █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     
          ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     
        ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  
        █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
      ▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
      █▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
          █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    
      ]],
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = vim.fn.isdirectory(".git") == 1,
						cmd = "hub status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = "startup" },
				},
			},
			statuscolumn = { enabled = false, right = { "git" } },
			dim = { animate = { enabled = false } },
			zen = { enabled = false },
			picker = {
				enabled = true,
				layout = {
					select = {
						layout = "ivy",
					},
					layout = {
						box = "horizontal",
						backdrop = false,
						width = 0.8,
						height = 0.9,
						border = "none",
						{
							box = "vertical",
							{
								win = "input",
								height = 1,
								border = "single",
								title = "{title} {live} {flags}",
								title_pos = "center",
							},
							{ win = "list", title = " Results ", title_pos = "center", border = "single" },
						},
						{
							win = "preview",
							title = "{preview:Preview}",
							width = 0.5,
							border = "single",
							title_pos = "center",
						},
					},
				},
				-- Fuzzy matching settings
				matcher = {
					fuzzy = true,
					smartcase = true,
					filename_bonus = true,
				},
			},
			words = { enabled = false },
			indent = {
				scope = { enabled = true, char = "┋" },
			},
			input = { enabled = true },
			notifier = { enabled = true, border = "single" },
		},
	},
}
