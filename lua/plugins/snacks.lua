return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			animate = {
				fps = 100,
			},
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
			statuscolumn = { enabled = true, right = { "git" } },
			dim = { animate = { enabled = "true" } },
			zen = { enabled = "false" },
			picker = {
				ui_select = true,
				layout = {
					layout = {
						backdrop = false,
						row = 2,
						width = 0.4,
						min_width = 80,
						height = 0.8,
						border = "none",
						box = "vertical",
					},
				},
				formatters = {
					file = {
						filename_first = true,
						truncate = 80,
					},
				},
				sources = {
					select = {
						layout = {
							layout = {
								backdrop = false,
								row = 2,
								width = 120,
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
									title_pos = "left",
								},
								{ win = "list", border = "single", height = 5 },
							},
						},
					},
					notifications = {
						layout = {
							preview = true,
							layout = {
								backdrop = false,
								row = 1,
								width = 0.4,
								min_width = 120,
								height = 0.8,
								border = "none",
								box = "vertical",
								{
									win = "input",
									height = 1,
									border = "single",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
								{ win = "list", border = "single" },
								{ win = "preview", title = "{preview}", border = "single" },
							},
						},
					},
					buffers = {
						prompt = "󰍉 ",
						layout = {
							preview = true,
							layout = {
								backdrop = false,
								row = 1,
								width = 0.4,
								min_width = 120,
								height = 0.8,
								border = "none",
								box = "vertical",
								{
									win = "input",
									height = 1,
									border = "single",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
								{ win = "list", border = "single" },
								{ win = "preview", title = "{preview}", border = "single" },
							},
						},
					},
					colorschemes = {
						prompt = "󱥚 ",
						layout = {
							preview = true,
							layout = {
								backdrop = false,
								row = 1,
								width = 0.4,
								min_width = 80,
								height = 0.8,
								border = "none",
								box = "vertical",
								{
									win = "input",
									height = 1,
									border = "single",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
								{ win = "list", border = "single" },
								{ win = "preview", title = "{preview}", border = "single" },
							},
						},
					},
					files = {
						prompt = "󰍉 ",
						layout = {
							layout = {
								backdrop = false,
								row = 2,
								width = 120,
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
									title_pos = "left",
								},
								{ win = "list", border = "single" },
							},
						},
					},
					grep = {
						prompt = "󰐰 ",
						layout = {
							preview = true,
							layout = {
								backdrop = false,
								row = 2,
								width = 120,
								min_width = 80,
								height = 0.8,
								border = "none",
								box = "vertical",
								title = "",
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
										width = 0.5,
										minimal = true,
									},
								},
							},
						},
					},
					lsp_references = {
						prompt = " ",
						layout = {
							preview = true,
							layout = {
								backdrop = false,
								row = 2,
								width = 150,
								min_width = 80,
								height = 0.8,
								border = "none",
								box = "vertical",
								title = "",
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
										width = 0.5,
										minimal = true,
									},
								},
							},
						},
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
