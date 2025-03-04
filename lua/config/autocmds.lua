-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- disable comment on new line
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("no_nl_comment"),
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Telling the LSP server the capability of FoldingRange
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local lang_servers = function()
	local servers = {}
	local configs = require("lspconfig.configs")

	for server, config in pairs(configs) do
		if config.manager ~= nil then
			table.insert(servers, server)
		end
	end
	return servers
end
for _, ls in ipairs(lang_servers()) do
	local config = {
		capabilities = capabilities,
		on_attach = on_attach,
		root_dir = require("lspconfig").util.root_pattern(".git"),
	}
	if ls == "clangd" then
		config.cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		}
	end
	if ls == "pyright" then
		config.settings = {
			python = {
				analysis = {
					typeCheckingMode = "basic",
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
				},
			},
		}
	end
	require("lspconfig")[ls].setup(config)
end

-- Disable inlay hints in insert mode
vim.api.nvim_create_autocmd({ "LspAttach", "InsertEnter", "InsertLeave" }, {
	callback = function(args)
		local enabled = args.event ~= "InsertEnter"
		vim.lsp.inlay_hint.enable(enabled, { bufnr = args.buf })
	end,
})

-- Autocmd for async cache to register buffer for VectorCode
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function()
-- 		local cacher = require("vectorcode.cacher")
--     local bufnr = vim.api.nvim_get_current_buf()
--     cacher.async_check("config", function()
--       cacher.register_buffer(
--         bufnr,
--         { notify = false, n_query = 10 },
--         require("vectorcode.utils").lsp_document_symbol_cb(),
--         { "BufWritePost" }
--       )
--     end, nil)
--   end,
--   desc = "Register buffer for VectorCode",
-- })
