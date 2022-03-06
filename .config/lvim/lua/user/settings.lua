local M = {}

M.config = function()
	vim.opt.laststatus = 0
	vim.opt.ruler = false
	vim.opt.showmode = false
	vim.opt.cmdheight = 1
	vim.opt.wrap = true
	vim.opt.relativenumber = true
	vim.opt.cursorline = false
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetypes = 0

	lvim.leader = "space"
	lvim.log.level = "warn"
	lvim.format_on_save = false
	lvim.lsp.diagnostics.virtual_text = false
	lvim.colorscheme = "rose-pine"
end

return M
