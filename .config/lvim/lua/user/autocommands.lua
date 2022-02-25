local M = {}

M.config = function()
	lvim.autocommands.custom_groups = {
		-- change line numbers depending on vim mode
		{ "InsertEnter", "*", ":set norelativenumber" },
		{ "InsertLeave", "*", ":set relativenumber" },

		-- disable auto commenting on newlines
		{ "FileType", "*", "set formatoptions-=c formatoptions -=r formatoptions -=o" },

		{ "BufWritePost", "/Users/cobcob/.config/lvim/config.lua", "lua require('user.theme').telescope_theme()" },
	}
end

return M
