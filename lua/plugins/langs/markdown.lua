return
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters = {
				["markdownlint-cli2"] = {
					prepend_args = {
						"--config",
						os.getenv("HOME") .. "/.config/nvim/rules/.markdownlint-cli2.yaml",
						"--",
					},
				},
			},
		},
	}

