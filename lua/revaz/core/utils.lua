-- Our core/utils.lua file
local M = {}
local opt = vim.opt

function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.toggleNumber()
	local relativenumber = opt.relativenumber:get()
	local number = opt.number:get()
	if relativenumber and number then
		opt.relativenumber = true
		opt.number = false
	elseif relativenumber then
		opt.relativenumber = false
		opt.number = true
	elseif number then
		opt.relativenumber = false
		opt.number = false
	else
		opt.number = true
		opt.relativenumber = true
	end
end

return M
