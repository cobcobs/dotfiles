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

    -- load telescope theme
		{ "Colorscheme", "*", "runtime plugin/highlights.vim" },

    -- match notify colors with rose-pine
    { "Colorscheme", "*", "hi NotifyERRORTitle guifg=#eb6f92"},
    { "Colorscheme", "*", "hi NotifyWARNTitle guifg=#eb6f92"},
    { "Colorscheme", "*", "hi NotifyINFOTitle guifg=#3e8fb0"},
    { "Colorscheme", "*", "hi NotifyTRACETitle guifg=#3e8fb0"},
    { "Colorscheme", "*", "hi NotifyERRORBorder guifg=#eb6f92"},
    { "Colorscheme", "*", "hi NotifyWARNBorder guifg=#eb6f92"},
    { "Colorscheme", "*", "hi NotifyINFOBorder guifg=#3e8fb0"},
    { "Colorscheme", "*", "hi NotifyTRACEBorder guifg=#3e8fb0"},
    { "Colorscheme", "*", "hi NotifyERRORIcon guifg=#eb6f92"},
    { "Colorscheme", "*", "hi NotifyWARNIcon guifg=#eb6f92"},
    { "Colorscheme", "*", "hi NotifyINFOIcon guifg=#3e8fb0"},
    { "Colorscheme", "*", "hi NotifyTRACEIcon guifg=#3e8fb0"},

    -- transparent window
		{ "Colorscheme", "*", "hi Normal ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi SignColumn ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi NormalNC ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi MsgArea ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi NvimTreeNormal ctermbg=none guibg=none" },
		{ "Colorscheme", "*", "hi FloatBorder guibg=#faf4ed guifg=#faf4ed" },
	}
end

return M
