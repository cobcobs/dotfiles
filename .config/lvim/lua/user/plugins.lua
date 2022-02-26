local M = {}

M.config = function()
	lvim.plugins = {
		{
			"projekt0n/github-nvim-theme",
			config = function()
				require("github-theme").setup({
					hide_inactive_statusline = false,
					transparent = true,
				})
			end,
		},
		{ "romainl/vim-cool", event = "CmdlineEnter" },
		{ "tpope/vim-repeat", event = "BufRead" },
		{ "tpope/vim-surround", event = "BufRead" },
		{
			"lukas-reineke/indent-blankline.nvim",
			event = "BufRead",
			setup = function()
				vim.g.indentLine_enabled = 1
				vim.g.indent_blankline_char = "▏"
				vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "alpha" }
				vim.g.indent_blankline_buftype_exclude = { "terminal" }
				vim.g.indent_blankline_show_trailing_blankline_indent = false
				vim.g.indent_blankline_show_first_indent_level = false
			end,
		},
		{
			"ethanholz/nvim-lastplace",
			event = "BufRead",
			config = function()
				require("nvim-lastplace").setup({
					lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
					lastplace_ignore_filetype = {
						"gitcommit",
						"gitrebase",
						"svn",
						"hgcommit",
					},
					lastplace_open_folds = true,
				})
			end,
		},
		{
			"goolord/alpha-nvim",
			config = function()
				require("alpha").setup(require("alpha.themes.dashboard").config)
			end,
		},
		{
			"nvim-telescope/telescope-frecency.nvim",
			config = function()
				require("telescope").load_extension("frecency")
			end,
		},
		{ "tami5/sqlite.lua" },
	}

	local greeter = require("alpha.themes.dashboard")
	greeter.section.header.val = {
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠞⢳⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠋⠀⢰⠎⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⢆⣤⡞⠃⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⢠⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⢀⣀⣾⢳⠀⠀⠀⠀⢸⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⣀⡤⠴⠊⠉⠀⠀⠈⠳⡀⠀⠀⠘⢎⠢⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀",
		"⠳⣄⠀⠀⡠⡤⡀⠀⠘⣇⡀⠀⠀⠀⠉⠓⠒⠺⠭⢵⣦⡀⠀⠀⠀",
		"⠀⢹⡆⠀⢷⡇⠁⠀⠀⣸⠇⠀⠀⠀⠀⠀⢠⢤⠀⠀⠘⢷⣆⡀⠀",
		"⠀⠀⠘⠒⢤⡄⠖⢾⣭⣤⣄⠀⡔⢢⠀⡀⠎⣸⠀⠀⠀⠀⠹⣿⡀",
		"⠀⠀⢀⡤⠜⠃⠀⠀⠘⠛⣿⢸⠀⡼⢠⠃⣤⡟⠀⠀⠀⠀⠀⣿⡇",
		"⠀⠀⠸⠶⠖⢏⠀⠀⢀⡤⠤⠇⣴⠏⡾⢱⡏⠁⠀⠀⠀⠀⢠⣿⠃",
		"⠀⠀⠀⠀⠀⠈⣇⡀⠿⠀⠀⠀⡽⣰⢶⡼⠇⠀⠀⠀⠀⣠⣿⠟⠀",
		"⠀⠀⠀⠀⠀⠀⠈⠳⢤⣀⡶⠤⣷⣅⡀⠀⠀⠀⣀⡠⢔⠕⠁⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠫⠿⠿⠿⠛⠋⠁⠀⠀⠀⠀",
	}
	greeter.section.buttons.val = {
		greeter.button("SPC n", "  New File", ":ene <BAR> startinsert <CR>"),
		greeter.button("SPC f", "  Find File", ":Telescope find_files<CR>"),
		greeter.button("SPC s t", "  Find Text", ":Telescope live_grep<CR>"),
		greeter.button("SPC s r", "  Recent File", ":Telescope frecency<CR>"),
		greeter.button("SPC s P", "  Recent Project", ":Telescope projects<CR>"),
		greeter.button("SPC L c", "  Configuration", ":e $HOME/.config/lvim/config.lua<CR>"),
		greeter.button("SPC q", "  Quit LunarVim", ":qa<CR>"),
	}
	greeter.section.footer.val = { "lunarvim.org" }
end

return M
