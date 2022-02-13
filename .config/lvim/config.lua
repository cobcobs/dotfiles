-- Additional Plugins
lvim.plugins = {
    {"projekt0n/github-nvim-theme"},
    {"romainl/vim-cool", event = "CmdlineEnter"},
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
lvim.colorscheme = "github_light"
lvim.transparent_window = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-p>"] = ":Telescope<cr>"
lvim.keys.normal_mode["<C-f>"] = ":Telescope current_buffer_fuzzy_find<cr>"
lvim.keys.normal_mode["<C-n>"] = ":NvimTreeToggle<cr>"
lvim.keys.normal_mode["j"] = {"v:count ? 'j' : 'gj'", {expr = true}}
lvim.keys.normal_mode["k"] = {"v:count ? 'k' : 'gk'", {expr = true}}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- enable/disable plugins
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.lualine.active = false

-- nvim-tree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- gitsigns
lvim.builtin.gitsigns.opts = {
  yadm = {
    enable = true
  }
}

-- nvim-cmp
lvim.builtin.cmp.sources = {
  {name = "luasnip"},
  {name = "nvim_lsp"},
  {name = "nvim_lua"},
  {name = "latex_symbols"},
  {name = "path"},
  {name = "buffer"},
}

-- telescope.nvim
lvim.builtin.telescope.pickers = {
  find_files = {
    find_command = {"fd", "--hidden"},
  },
  builtin = {
    theme = "dropdown"
  }
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

-- generic LSP settings
-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    command = "prettier",
    extra_args = { "--print-with", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    command = "shellcheck",
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    filetypes = { "javascript", "python" },
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  -- return to last edit position when opening files
  { "BufReadPost", "*", [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]] },

  -- change line numbers depending on vim mode
  { "InsertEnter", "*", ":set norelativenumber" },
  { "InsertLeave", "*", ":set relativenumber" },

  -- disable auto commenting on newlines
  { "FileType", "*", "set formatoptions-=c formatoptions -=r formatoptions -=o" },

  -- colorscheme
  { "ColorScheme", "*", ":hi Cursorline ctermbg=none guibg=none"}
}

