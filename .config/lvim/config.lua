-- Additional Plugins
lvim.plugins = {
	{ "projekt0n/github-nvim-theme" },
	{ "romainl/vim-cool", event = "CmdlineEnter" },
	{ "tpope/vim-repeat", event = "BufRead" },
	{ "tpope/vim-surround", event = "BufRead" },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = function()
			vim.g.indentLine_enabled = 1
			vim.g.indent_blankline_char = "▏"
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
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
}

-- general vim settings
vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.cmdheight = 1
vim.opt.wrap = true

-- general lvim settings
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lsp.diagnostics.virtual_text = false
lvim.colorscheme = "github_light"
lvim.transparent_window = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-p>"] = ":Telescope<cr>"
lvim.keys.normal_mode["<C-f>"] = ":Telescope current_buffer_fuzzy_find<cr>"

lvim.keys.normal_mode["cn"] = [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]]
lvim.keys.normal_mode["cN"] = [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]]
lvim.keys.normal_mode["j"] = { "v:count ? 'j' : 'gj'", { expr = true } }
lvim.keys.normal_mode["k"] = { "v:count ? 'k' : 'gk'", { expr = true } }

lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<CR>", "Find File" }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- enable/disable plugins
lvim.builtin.bufferline.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.lualine.active = false
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- dashboard
lvim.builtin.dashboard.custom_header = {
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
lvim.builtin.dashboard.custom_section.a = {
	command = "Telescope find_files",
	description = { "  Find File           " },
}
lvim.builtin.dashboard.custom_section.b = {
	command = ":ene!",
	description = { "  New File           " },
}

-- nvim-tree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- gitsigns
lvim.builtin.gitsigns.opts = {
	yadm = {
		enable = true,
	},
}

-- nvim-cmp
lvim.builtin.cmp.sources = {
	{ name = "luasnip" },
	{ name = "nvim_lsp" },
	{ name = "nvim_lua" },
	{ name = "path" },
	{ name = "buffer" },
}

-- telescope.nvim
lvim.builtin.telescope.pickers = {
	find_files = {
		find_command = { "fd", "--hidden" },
	},
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	-- change line numbers depending on vim mode
	{ "InsertEnter", "*", ":set norelativenumber" },
	{ "InsertLeave", "*", ":set relativenumber" },

	-- disable auto commenting on newlines
	{ "FileType", "*", "set formatoptions-=c formatoptions -=r formatoptions -=o" },

	-- colorscheme
	{ "ColorScheme", "*", ":hi Cursorline ctermbg=none guibg=none" },
}
