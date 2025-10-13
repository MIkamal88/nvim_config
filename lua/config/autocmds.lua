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

-- Disable inlay hints in insert mode
vim.api.nvim_create_autocmd({ "LspAttach", "InsertEnter", "InsertLeave" }, {
	callback = function(args)
		local enabled = args.event ~= "InsertEnter"
		vim.lsp.inlay_hint.enable(enabled, { bufnr = args.buf })
	end,
})

-- CSV view on .csv files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "csv",
	desc = "Enable CSV View on .csv files",
	callback = function()
		require("csvview").enable()
	end,
})
