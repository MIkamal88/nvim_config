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
				layout = {
					preview = true,
					layout = {
						backdrop = false,
						row = 2,
						width = 260,
						min_width = 80,
						height = 0.8,
						border = "none",
						box = "vertical",
						{
							win = "input",
							height = 1,
							row = 1,
							border = "single",
							title = "{title} {live} {flags}",
							title_pos = "center",
						},
						{
							box = "horizontal",
							{ win = "list", border = "single" },
							{
								win = "preview",
								title = "{preview}",
								border = "single",
								width = 0.7,
								minimal = false,
							},
						},
					},
				},
				formatters = {
					file = {
						filename_first = true,
						truncate = 80,
					},
				},
			},
			words = { enabled = false },
			indent = {
				scope = { enabled = true, char = "┋" },
			},
			input = { enabled = true },
		},
	},
}
