---@diagnostic disable: param-type-mismatch
local M = {}

local augroup = vim.api.nvim_create_augroup

M.my_augroup = augroup('MyAugroup', {})

return M
