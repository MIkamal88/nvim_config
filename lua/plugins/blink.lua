local function is_online()
	local now = os.time()
	local last_online_check, online_status
	local online_cache_timeout = 30
	if last_online_check and (now - last_online_check < online_cache_timeout) then
		return online_status
	end
	online_status = vim.system({ "ping", "-c", "1", "8.8.8.8" }, { timeout = 1000 }):wait().code == 0
	last_online_check = now
	return online_status
end

-- Extend neovim's client capabilities with the completion ones
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })

-- Autocmd settings
local blink_cmp_augroup = vim.api.nvim_create_augroup("blink_cmp", { clear = true })
vim.api.nvim_create_autocmd("User", {
	desc = "Show Blink completion menu on Luasnip insert node enter",
	group = blink_cmp_augroup,
	pattern = "LuasnipInsertNodeEnter",
	callback = function()
		vim.schedule(function()
			local mode = vim.api.nvim_get_mode().mode
			if not mode:match("^[sS]$") then
				require("blink.cmp").show()
			end
		end)
	end,
})

-- Setup
return {
	{
		"saghen/blink.cmp",
		dependencies = { "Kaiser-Yang/blink-cmp-git" },
		config = function()
			require("blink.cmp").setup({
				fuzzy = {
					implementation = "rust",
					frecency = {
						enabled = true,
						path = vim.fn.stdpath("state") .. "/blink/cmp/frecency.dat",
					},
					sorts = {
						"score",
						"sort_text",
					},
				},
				completion = {
					menu = {
						border = "single",
						winhighlight = "Normal:NormalFloat,CursorLine:PmenuSel,Search:None",
						draw = {
							columns = {
								{ "kind_icon" },
								{ "label", "label_description", gap = 1 },
								{ "source_name" },
							},
							components = {
								source_name = {
									text = function(ctx)
										local map = {
											buffer = "[Buffer]",
											codecompanion = "[CodeCompanion]",
											git = "[Git]",
											lsp = "[LSP]",
											luasnip = "[Snippet]",
											path = "[Path]",
										}
										return map[ctx.source_id]
											or map[ctx.source_name]
											or ("[" .. (ctx.source_name or ctx.source_id or "?") .. "]")
									end,
									highlight = function(ctx)
										local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
										return hl
									end,
								},
								kind_icon = {
									text = function(ctx)
										local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
										return kind_icon
									end,
									highlight = function(ctx)
										local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
										return hl
									end,
								},
								kind = {
									highlight = function(ctx)
										local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
										return hl
									end,
								},
							},
						},
					},
					trigger = {
						show_on_trigger_character = true,
						show_on_insert_on_trigger_character = true,
						show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
					},
					list = {
						selection = {
							preselect = true,
							auto_insert = true,
						},
						max_items = 50,
					},
					documentation = {
						auto_show = true,
						treesitter_highlighting = true,
						window = {
							border = "single",
							winhighlight = "Normal:NormalFloat,Search:None",
						},
						draw = function(opts)
							opts.default_implementation()
							_G.LspConfig.highlight_doc_patterns(opts.window.buf)
							local win_id = opts.window:get_win()
							if win_id then
								require("render-markdown.core.ui").update(opts.window.buf, win_id, "BlinkDraw", true)
							end
						end,
					},
					ghost_text = { enabled = true },
				},
				signature = {
					enabled = true,
					window = {
						min_width = 1,
						max_width = 100,
						max_height = 10,
						border = "single",
						winhighlight = "Normal:NormalFloat,Search:None",
						treesitter_highlighting = true,
						show_documentation = true,
					},
				},
				keymap = {
					preset = "default",
					["<Enter>"] = {
						function(cmp)
							if cmp.snippet_active() then
								return cmp.accept()
							else
								return cmp.select_and_accept()
							end
						end,
						"snippet_forward",
						"fallback",
					},
				},
				sources = {
					default = function()
						local sources = { "buffer", "lsp", "path", "snippets", "lazydev", "dadbod" }
						if vim.bo.filetype == "gitcommit" then
							sources = is_online() and { "buffer", "git" } or { "buffer" }
						end
						return sources
					end,
					per_filetype = {
						codecompanion = { "codecompanion" },
						lua = { inherit_defaults = true, "lazydev" },
						sql = { "dadbod", "buffer" },
					},
					providers = {
						buffer = {
							min_keyword_length = 2,
							max_items = 3,
							module = "blink.cmp.sources.buffer",
							score_offset = 65,
							transform_items = function(a, items)
								local keyword = a.get_keyword()
								local correct, case
								if keyword:match("^%l") then
									correct = "^%u%l+$"
									case = string.lower
								elseif keyword:match("^%u") then
									correct = "^%l+$"
									case = string.upper
								else
									return items
								end

								-- avoid duplicates from the corrections
								local seen = {}
								local out = {}
								for _, item in ipairs(items) do
									local raw = item.insertText
									if raw and raw:match(correct) then
										local text = case(raw:sub(1, 1)) .. raw:sub(2)
										item.insertText = text
										item.label = text
									end
									if not seen[item.insertText] then
										seen[item.insertText] = true
										table.insert(out, item)
									end
								end
								return out
							end,
						},
						path = {
							name = "Path",
							module = "blink.cmp.sources.path",
							score_offset = 70,
							min_keyword_length = 2,
							fallbacks = { "snippets", "buffer" },
							opts = {
								trailing_slash = false,
								label_trailing_slash = true,
								get_cwd = function(context)
									return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
								end,
								show_hidden_files_by_default = true,
							},
						},
						codecompanion = {
							name = "codecompanion",
							module = "codecompanion.providers.completion.blink",
							transform_items = function(_, items)
								for _, item in ipairs(items) do
									item.kind_icon = " "
								end
								return items
							end,
							score_offset = function()
								return 100
							end,
						},
						snippets = {
							name = "Snippets",
							module = "blink.cmp.sources.snippets",
							min_keyword_length = 2,
							score_offset = 80,
						},
						dadbod = {
							name = "Dadbod",
							module = "vim_dadbod_completion.blink",
							min_keyword_length = 2,
							score_offset = 80,
						},
						git = {
							name = "Git",
							module = "blink-cmp-git",
						},
						lazydev = {
							name = "Lazydev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
						lsp = {
							name = "lsp",
							module = "blink.cmp.sources.lsp",
							score_offset = 95,
							transform_items = function(_, items)
								local cmp_kind = require("blink.cmp.types").CompletionItemKind
								return vim.tbl_filter(function(item)
									-- Don't show lsp text and snippets
									return item.kind ~= cmp_kind.Text and item.kind ~= cmp_kind.Snippet
								end, items)
							end,
						},
					},
				},
				snippets = {
					preset = "luasnip",
					expand = function(snippet)
						require("luasnip").lsp_expand(snippet)
					end,
					active = function(filter)
						if filter and filter.direction then
							return require("luasnip").jumpable(filter.direction)
						end
						return require("luasnip").in_snippet()
					end,
					jump = function(direction)
						require("luasnip").jump(direction)
					end,
				},
				cmdline = {
					enabled = true,
					completion = {
						menu = {
							auto_show = true,
						},
					},
					sources = function()
						local type = vim.fn.getcmdtype()
						if type == ":" then
							return { "cmdline", "path" }
						elseif type == "@" then
							return { "path" }
						end
						return {}
					end,
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		event = "InsertEnter",
		postinstall = "make install_jsregexp",
		config = function()
			local luasnip = require("luasnip")
			luasnip.setup({
				snippets_path = { vim.fn.stdpath("config") .. "/snippets" },
				history = true,
				updateevents = "TextChanged,TextChangedI",
				delete_check_events = "TextChanged",
				enable_autosnippets = true,
			})
			-- add vscode exported completions
			require("luasnip.loaders.from_vscode").lazy_load()
			-- load loremipsum snippets from friendly-snippets
			require("luasnip").filetype_extend("all", { "loremipsum" })
			local r = require("utils.remaps")

			r.map({ "i", "s" }, "<c-n>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, "Expand current snippet or jump to next", { silent = true })

			r.map({ "i", "s" }, "<c-p>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, "Go to previous snippet", { silent = true })
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
	},
}
