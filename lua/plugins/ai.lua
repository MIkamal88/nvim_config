local preprompt =
	"Think step by step. Consider my prompt carefully and think of the academic or professional expertise of someone that could best answer my question. You have the experience of someone with expert knowledge in that area. Be helpful and answer in detail while preferring to use information from reputable sources. "
local prompts = {
  -- Code related prompts
  Explain = preprompt .. "Please explain how the following code works.",
  Review = preprompt .. "Please review the following code and provide suggestions for improvement.",
  Tests = preprompt .. "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = preprompt .. "Please refactor the following code to improve its clarity and readability.",
  FixCode = preprompt .. "Please fix the following code to make it work as intended.",
  FixError = preprompt .. "Please explain the error in the following text and provide a solution.",
  BetterNamings = preprompt .. "Please provide better names for the following variables and functions.",
  Documentation = preprompt .. "Please provide documentation for the following code.",
  SwaggerApiDocs = preprompt .. "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = preprompt .. "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		opts = {
			prompts = prompts,
			mappings = {
				reset = {
					normal = "C-x",
					insert = "C-x",
				},
			},
		},
		config = function (_, opts)
			require('CopilotChat').setup(opts)
		end,
	},

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-c>",
          next = "<M-e>",
          prev = "<M-q>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(
        opts.sections.lualine_x,
        2,
        LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
          local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
          if #clients > 0 then
            local status = require("copilot.api").status.data.status
            return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
          end
        end)
      )
    end,
  },
}
