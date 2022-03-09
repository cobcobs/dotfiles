local M = {}

M.config = function()
	lvim.plugins = {
		{
			"rose-pine/neovim",
			as = "rose-pine",
			tag = "v1.*",
		},
		{ "romainl/vim-cool", event = "CmdlineEnter" },
		{ "tpope/vim-repeat", event = "BufRead" },
		{
			"lukas-reineke/indent-blankline.nvim",
			event = "BufRead",
			setup = function()
				vim.g.indentLine_enabled = 1
				vim.g.indent_blankline_char = "▏"
				vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "alpha", "packer" }
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
			"nvim-telescope/telescope-frecency.nvim",
			config = function()
				require("telescope").load_extension("frecency")
			end,
		},
		{ "tami5/sqlite.lua" },
		{ "lervag/vimtex" },
    { "echasnovski/mini.nvim" }
	}

  require("mini.surround").setup()
  require("mini.comment").setup()
  local my_items = {
    { name = "New File", action = ":ene <BAR> startinsert", section = "Commands"},
    { name = "Configuration", action = ":e $HOME/.config/lvim/config.lua", section = "Commands"},
    { name = "File", action = ":Telescope find_files", section = "Telescope"},
    { name = "Grep", action = ":Telescope live_grep", section = "Telescope"},
    { name = "Frecency", action = ":Telescope frecency", section = "Telescope"},
    { name = "Project", action = ":Telescope projects", section = "Telescope"},
  }
  local starter = require('mini.starter')
  starter.setup({
    items = my_items,
    footer = "lunarvim.org",
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning('center', 'center'),
    },
  })

	vim.g.vimtex_view_method = "zathura"
  vim.cmd([[
    let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
  ]])
end

return M
