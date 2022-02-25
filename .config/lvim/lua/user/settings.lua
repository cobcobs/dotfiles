local M = {}

M.config = function()
	vim.opt.laststatus = 0
	vim.opt.ruler = false
	vim.opt.showmode = false
	vim.opt.cmdheight = 1
	vim.opt.wrap = true
	vim.opt.relativenumber = true
	vim.opt.cursorline = false
end

return M
