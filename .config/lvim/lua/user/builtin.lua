local M = {}

M.config = function()
	lvim.builtin.bufferline.active = true
	lvim.builtin.dashboard.active = false
	lvim.builtin.lualine.active = false
	lvim.builtin.notify.active = true
	lvim.builtin.terminal.active = true

  lvim.builtin.terminal.float_opts.border = "none"
  lvim.builtin.terminal.float_opts.highlights.background = "TelescopeNormal"

	lvim.builtin.treesitter.ignore_install = { "haskell" }
	lvim.builtin.treesitter.highlight.enabled = true
	lvim.builtin.treesitter.indent = { enable = true, disable = { "yaml", "python" } }

	lvim.builtin.nvimtree.setup.view.side = "left"
	lvim.builtin.nvimtree.show_icons.git = 0

	lvim.builtin.gitsigns.opts = {
		yadm = {
			enable = true,
		},
	}

	lvim.builtin.cmp.sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "buffer" },
	}

	lvim.builtin.telescope.pickers = {
		find_files = {
			find_command = { "fd", "--hidden" },
		},
	}
	lvim.builtin.telescope.defaults.prompt_prefix = "  "
	lvim.builtin.telescope.defaults.border = {}
	lvim.builtin.telescope.defaults.borderchars = { " " }
	lvim.builtin.telescope.defaults.selection_caret = "  "
	lvim.builtin.telescope.defaults.layout_config = {
		horizontal = {
			prompt_position = "top",
			preview_width = 0.55,
			results_width = 0.8,
		},
		vertical = {
			mirror = false,
		},
		width = 0.87,
		height = 0.80,
		preview_cutoff = 120,
	}
	lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
	lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
end

return M
