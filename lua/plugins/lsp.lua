_G.LspConfig = {}

-- Define higlights for markdown hover documentation
local md_docs_ns = vim.api.nvim_create_namespace("markdown_docs_highlights")
function _G.LspConfig.highlight_doc_patterns(bufnr)
	vim.api.nvim_buf_clear_namespace(bufnr, md_docs_ns, 0, -1)
	local patterns = {
		["─"] = "RenderMarkdownDash",
		["---"] = "RenderMarkdownDash",
		-- Lua/vimdoc
		["@%S+"] = "@variable.parameter",
		-- Python
		["^%s*(Parameters)$"] = "@markup.heading.vimdoc",
		["^%s*(Returns)$"] = "@markup.heading.vimdoc",
		["^%s*(Examples)$"] = "@markup.heading.vimdoc",
		["^%s*(Notes)$"] = "@markup.heading.vimdoc",
		["^%s*(See Also)$"] = "@markup.heading.vimdoc",
	}

	for l, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
		if vim.startswith(line, "``` man") then
			vim.bo[bufnr].filetype = "man"
			return
		end

		for pattern, hl_group in pairs(patterns) do
			local from = 1
			while true do
				local s, e = line:find(pattern, from)
				if not s then
					break
				end
				vim.api.nvim_buf_set_extmark(bufnr, md_docs_ns, l - 1, s - 1, {
					end_col = e,
					hl_group = hl_group,
				})
				from = e + 1
			end
		end
	end
end

return {
	{
		"folke/noice.nvim",
		opts = {
			cmdline = { view = "cmdline" },
			presets = { lsp_doc_border = true },
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
		config = function()
			require("render-markdown").setup({
				enabled = true,
				file_types = { "markdown", "codecompanion" },
				render_modes = true,
				win_options = {
					conceallevel = { rendered = 2 },
					concealcursor = { rendered = "nc" },
				},
				anti_conceal = {
					ignore = {
						bullet = { "n" },
						callout = { "n" },
						check_icon = { "n" },
						check_scope = { "n" },
						code_language = { "n" },
						dash = { "n" },
						head_icon = { "n" },
						link = { "n" },
						quote = { "n" },
						table_border = { "n" },
					},
				},
				dash = {
					width = 80,
				},
				heading = {
					sign = false,
					icons = { "󰪥 ", "󰺕 ", " ", " ", " ", "" },
					position = "inline",
				},
				bullet = {
					icons = { "", "•", "", "-", "-" },
				},
				checkbox = {
					unchecked = { icon = "" },
					checked = { icon = "", scope_highlight = "@markup.strikethrough" },
					custom = {
						doing = {
							raw = "[_]",
							rendered = "󰄮",
							highlight = "RenderMarkdownDoing",
						},
						wontdo = {
							raw = "[~]",
							rendered = "󰅗",
							highlight = "RenderMarkdownWontdo",
						},
					},
				},
				code = {
					sign = false,
					width = "block",
					border = "thick",
					min_width = 80,
					highlight_language = "LineNr",
					language_name = false,
				},
				quote = { icon = "▐" },
				pipe_table = { cell = "raw" },
				link = {
					wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
					custom = {
						gdrive = {
							pattern = "drive%.google%.com/drive",
							icon = " ",
						},
						spreadsheets = {
							pattern = "docs%.google%.com/spreadsheets",
							icon = "󰧷 ",
						},
						document = {
							pattern = "docs%.google%.com/document",
							icon = "󰈙 ",
						},
						presentation = {
							pattern = "docs%.google%.com/presentation",
							icon = "󰈩 ",
						},
					},
				},
				latex = { enabled = false },
				html = { comment = { conceal = false } },
				on = {
					render = function(ctx)
						local is_lsp_float = pcall(vim.api.nvim_win_get_var, ctx.win, "lsp_floating_bufnr")
						if is_lsp_float then
							_G.LspConfig.highlight_doc_patterns(ctx.buf)
						end
					end,
				},
				overrides = {
					filetype = {
						-- CodeCompanion
						codecompanion = {
							heading = {
								icons = { "󰪥 ", "  ", " ", " ", " ", "" },
								custom = {
									codecompanion_input = {
										pattern = "^## Me$",
										icon = " ",
										background = "CodeCompanionInputHeader",
									},
								},
							},
							html = {
								tag = {
									buf = {
										icon = "󰌹 ",
										highlight = "Comment",
									},
									image = {
										icon = "󰥶 ",
										highlight = "Comment",
									},
									file = {
										icon = "󰨸 ",
										highlight = "Comment",
									},
									url = {
										icon = " ",
										highlight = "Comment",
									},
								},
							},
						},
					},
				},
			})
		end,
	},
}
