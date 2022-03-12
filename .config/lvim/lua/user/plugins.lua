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
      after = "telescope.nvim",
      requires = {"tami5/sqlite.lua"},
			config = function()
				require("telescope").load_extension("frecency")
			end,
		},
		{ "lervag/vimtex" },
    { "echasnovski/mini.nvim" }
	}

  require("mini.surround").setup()
  require("mini.comment").setup()
  require("mini.indentscope").setup {
    draw = {
        animation = require("mini.indentscope").gen_animation("none")
    },
    symbol = "│",
    try_as_border = true,
  }
  local my_items = {
    { name = "New File", action = ":ene", section = "Commands"},
    { name = "Configuration", action = ":e $HOME/.config/lvim/config.lua", section = "Commands"},
    { name = "File", action = ":Telescope find_files", section = "Commands"},
    { name = "Grep", action = ":Telescope live_grep", section = "Commands"},
    { name = "Frecency", action = ":Telescope frecency", section = "Commands"},
    { name = "Project", action = ":Telescope projects", section = "Commands"},
    { name = "Quit", action = ":q", section = "Commands"},
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
  vim.g.vimtex_compiler_progname = "nvr"
	-- vim.g.vimtex_view_general_viewer = "kitty"
	-- vim.g.vimtex_view_general_options = "--single-instance termpdf.py @pdf"
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
