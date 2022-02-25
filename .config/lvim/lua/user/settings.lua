local M = {}

M.config = function()
	vim.opt.laststatus = 0
	vim.opt.ruler = false
	vim.opt.showmode = false
	vim.opt.cmdheight = 1
	vim.opt.wrap = true
	vim.opt.relativenumber = true
	vim.opt.cursorline = false

	lvim.leader = "space"
	lvim.log.level = "warn"
	lvim.format_on_save = true
	lvim.lsp.diagnostics.virtual_text = false
	lvim.colorscheme = "github_light"
end

return M
