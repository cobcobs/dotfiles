local M = {}

M.config = function()
	lvim.autocommands.custom_groups = {
		-- change line numbers depending on vim mode
		{ "InsertEnter", "*", ":set norelativenumber" },
		{ "InsertLeave", "*", ":set relativenumber" },

		-- disable auto commenting on newlines
		{ "FileType", "*", "set formatoptions-=c formatoptions -=r formatoptions -=o" },

		{ "Colorscheme", "*", "runtime plugin/highlights.vim" },
		{ "Colorscheme", "*", "hi Normal ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi SignColumn ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi NormalNC ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi MsgArea ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi NvimTreeNormal ctermbg=none guibg=none" },
	}
end

return M
