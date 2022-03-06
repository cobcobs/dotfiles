local M = {}

local parsers = require("nvim-treesitter.parsers")
function _G.ensure_treesitter_language_installed()
	local lang = parsers.get_buf_lang()
	if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
		vim.schedule_wrap(function()
			vim.cmd("TSInstallSync " .. lang)
			vim.cmd([[e!]])
		end)()
	end
end

vim.cmd([[autocmd FileType * :lua ensure_treesitter_language_installed()]])

M.config = function()
	lvim.autocommands.custom_groups = {
		-- change line numbers depending on vim mode
		{ "InsertEnter", "*", ":set norelativenumber" },
		{ "InsertLeave", "*", ":set relativenumber" },

		-- disable auto commenting on newlines
		{ "FileType", "*", "set formatoptions-=c formatoptions -=r formatoptions -=o" },

		-- install new treesitter parser when encountering a new filetype
		-- https://github.com/nvim-treesitter/nvim-treesitter/issues/2108#issuecomment-993642212
		{ "FileType", "*", ":lua ensure_treesitter_language_installed()" },

		{ "Colorscheme", "*", "runtime plugin/highlights.vim" },

		{ "Colorscheme", "*", "hi Normal ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi SignColumn ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi NormalNC ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi MsgArea ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi NvimTreeNormal ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi FloatBorder guibg=#faf4ed guifg=#faf4ed" },
	}
end

return M
