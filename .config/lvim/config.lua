-- additional plugins
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

-- general vim settings
vim.opt.laststatus = 0
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.cmdheight = 1
vim.opt.wrap = true
vim.opt.relativenumber = true
vim.opt.cursorline = false

-- general lvim settings
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lsp.diagnostics.virtual_text = false
lvim.colorscheme = "github_light"
lvim.transparent_window = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.keys.normal_mode["<C-p>"] = ":Telescope<CR>"

lvim.keys.normal_mode["cn"] = [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]]
lvim.keys.normal_mode["cN"] = [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]]
lvim.keys.normal_mode["j"] = { "v:count ? 'j' : 'gj'", { expr = true } }
lvim.keys.normal_mode["k"] = { "v:count ? 'k' : 'gk'", { expr = true } }

lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<CR>", "Find File" }
lvim.builtin.which_key.mappings["c"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" }
lvim.builtin.which_key.mappings["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy Find" }
lvim.builtin.which_key.mappings[";"] = { "<cmd>Alpha<CR>", "Dashboard" }
lvim.builtin.which_key.mappings["bd"] = { "<cmd>BufferKill<CR>", "Delete Buffer" }

-- after changing plugin config exit and reopen LunarVim, run :PackerInstall :PackerCompile
-- enable/disable plugins
lvim.builtin.bufferline.active = true
lvim.builtin.dashboard.active = false
lvim.builtin.lualine.active = false
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- alpha-nvim
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
	greeter.button("SPC P", "  Recent Project", ":Telescope projects<CR>"),
	greeter.button("SPC L c", "  Configuration", ":e $HOME/.config/lvim/config.lua<CR>"),
	greeter.button("SPC q", "  Quit LunarVim", ":qa<CR>"),
}
greeter.section.footer.val = { "lunarvim.org" }

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
lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"

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

-- autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	-- change line numbers depending on vim mode
	{ "InsertEnter", "*", ":set norelativenumber" },
	{ "InsertLeave", "*", ":set relativenumber" },

	-- disable auto commenting on newlines
	{ "FileType", "*", "set formatoptions-=c formatoptions -=r formatoptions -=o" },
}
