local M = {}

M.telescope_theme = function()
	local colors = {
		bg = "#F1E7CF",
		bg_alt = "#F7F1E3",
		fg = "#211A15",
		green = "#76946A",
		red = "#EB7373",
	}

	local function set_bg(group, bg)
		vim.cmd("hi " .. group .. " guibg=" .. bg)
	end

	local function set_fg_bg(group, fg, bg)
		vim.cmd("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg)
	end

	set_fg_bg("TelescopeBorder", colors.bg, colors.bg)
	set_fg_bg("TelescopePromptBorder", colors.bg, colors.bg)
	set_fg_bg("TelescopePromptNormal", colors.fg, colors.bg)
	set_fg_bg("TelescopePromptPrefix", colors.red, colors.bg)
	set_fg_bg("TelescopePreviewTitle", colors.bg, colors.green)
	set_fg_bg("TelescopePromptTitle", colors.bg, colors.red)
	set_fg_bg("TelescopeResultsTitle", colors.bg, colors.bg)
	set_fg_bg("TelescopeResultsBorder", colors.bg, colors.bg)
	set_fg_bg("LvimInfoHeader", colors.bg, colors.green)
	set_fg_bg("LvimInfoIdentifier", colors.red, colors.bg)
	set_bg("TelescopeSelection", colors.bg_alt)
	set_bg("TelescopeNormal", colors.bg)
end

return M
