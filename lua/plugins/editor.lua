return {
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = { "kevinhwang91/promise-async", event = "BufReadPost" },
		opts = {
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("   %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
			open_fold_hl_timeout = 0,
		},
	},
	{ "stevearc/conform.nvim", event = "BufWritePre" },
	{
		"maskudo/devdocs.nvim",
		lazy = false,
		dependencies = {
			"folke/snacks.nvim",
		},
		cmd = { "DevDocs" },
		keys = {
			{
				"<leader>ho",
				mode = "n",
				"<cmd>DevDocs get<cr>",
				desc = "Get Devdocs",
			},
			{
				"<leader>hi",
				mode = "n",
				"<cmd>DevDocs install<cr>",
				desc = "Install Devdocs",
			},
			{
				"<leader>hv",
				mode = "n",
				function()
					local devdocs = require("devdocs")
					local installedDocs = devdocs.GetInstalledDocs()
					vim.ui.select(installedDocs, {}, function(selected)
						if not selected then
							return
						end
						local docDir = devdocs.GetDocDir(selected)
						vim.notify(docDir)
						-- prettify the filename as you wish
						Snacks.picker.files({ cwd = docDir })
					end)
				end,
				desc = "Get Devdocs",
			},
			{
				"<leader>hd",
				mode = "n",
				"<cmd>DevDocs delete<cr>",
				desc = "Delete Devdoc",
			},
		},
		opts = {
			ensure_installed = {
				"lua~5.1",
        "html",
				"http",
        "css",
        "sass",
        "python~3.11",
        "sqlite",
        "postgresql~16",
        "tailwindcss",
        "react",
        "typescript",
        "markdown",
			},
		},
	},
}
