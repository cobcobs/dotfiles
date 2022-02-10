-- packer.nvim bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- startup and add plugins
require("packer").startup(function(use)
    -- package manager
    use {"wbthomason/packer.nvim"}

    -- reduce startup
    use {"lewis6991/impatient.nvim"}

    -- lsp
    use {"neovim/nvim-lspconfig"}
    use {"williamboman/nvim-lsp-installer"}
    use {"onsails/lspkind-nvim"}

    -- completion
    use {"hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-buffer", event = "InsertEnter"}
    use {"hrsh7th/cmp-path", event = "InsertEnter"}
    use {"hrsh7th/cmp-nvim-lua", event = "InsertEnter"}
    use {"hrsh7th/cmp-nvim-lsp", event = "InsertEnter"}
    use {"L3MON4D3/LuaSnip", event = "InsertEnter"}
    use {"saadparwaiz1/cmp_luasnip", event = "InsertEnter"}
    use {"kdheepak/cmp-latex-symbols", event = "InsertEnter"}

    -- debugging
    use {"mfussenegger/nvim-dap"}
    use {"Pocco81/DAPInstall.nvim"}

    -- visuals
    use {"lewis6991/gitsigns.nvim"}
    use {"lukas-reineke/indent-blankline.nvim"}
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"romainl/vim-cool", event = "CmdlineEnter"}
    use {"ellisonleao/gruvbox.nvim"}

    -- others
    use {"echasnovski/mini.nvim"}
    use {"nvim-telescope/telescope.nvim"}
    use {"LinArcX/telescope-command-palette.nvim"}
    use {"nvim-lua/plenary.nvim"}

    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- setup plugins
-- mini.nvim
require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.surround").setup()

-- visuals
require("gitsigns").setup {
    yadm = {
        enable = true
    },
}
require("indent_blankline").setup()
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
}

-- telescope.nvim
require("telescope").setup {
    extensions = {
    command_palette = {
      {"File",
        { "entire selection (C-a)", ':call feedkeys("GVgg")' },
        { "save current file (C-s)", ':w' },
        { "save all files (C-A-s)", ':wa' },
        { "quit (C-q)", ':qa' },
        { "search word (A-w)", ":lua require('telescope.builtin').live_grep({hidden=true})", 1 },
        { "git files (A-f)", ":lua require('telescope.builtin').git_files({hidden=true})", 1 },
        { "files (C-f)",     ":lua require('telescope.builtin').find_files({hidden=true})", 1 },
      },
      {"Help",
        { "tips", ":help tips" },
        { "cheatsheet", ":help index" },
        { "tutorial", ":help tutor" },
        { "summary", ":help summary" },
        { "quick reference", ":help quickref" },
        { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
      },
      {"Vim",
        { "reload vimrc", ":source $MYVIMRC" },
        { 'check health', ":checkhealth" },
        { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
        { "colorscheme", ":lua require('telescope.builtin').colorscheme()", 1 },
        { "vim options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
        { "paste mode", ':set paste!' },
        { 'cursor line', ':set cursorline!' },
        { 'cursor column', ':set cursorcolumn!' },
        { "spell checker", ':set spell!' },
        { "relative number", ':set relativenumber!' },
        { "search highlighting (F12)", ':set hlsearch!' },
      }
    }
  }
}
require('telescope').load_extension('command_palette')

-- completion
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require("cmp").setup({
    completion = {
        autocomplete = false,
        completeopt = "menu, menuone, noinsert",
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ["<Tab>"] = require("cmp").mapping(function(fallback)
            if require("cmp").visible() then
                require("cmp").select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
            elseif has_words_before() then
                require("cmp").complete()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = require("cmp").mapping(function(fallback)
            if require("cmp").visible() then
                require("cmp").select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<CR>"] = require("cmp").mapping.confirm({
            behavior = require("cmp").ConfirmBehavior.Insert,
            select = false,
        }),
    },
    sources = {
        {name = "nvim_lua"},
        {name = "nvim_lsp"},
        {name = "latex_symbols"},
        {name = "path"},
        {name = "luasnip"},
        {name = "buffer"},
    },
    formatting = {
        format = require("lspkind").cmp_format({with_text = true, menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LateX]",
        })}),
    },
})

-- lspconfig
require("lspconfig").pyright.setup{}

-- disable built in plugins
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_matchit = 0
vim.g.loaded_matchparen = 0
vim.g.loaded_spec = 0


-- nvim settings
vim.cmd("filetype plugin indent on")
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.backspace = "indent,eol,start"
vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
vim.opt.hidden = true
vim.opt.lazyredraw = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildcharm = vim.fn.char2nr("^Z")
vim.opt.cmdheight = 1
vim.opt.scrolloff = 5
vim.opt.laststatus = 0
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("config") .. "/undodir"
vim.opt.shortmess = "cat"
vim.opt.conceallevel = 2
vim.opt.title = true


-- mappings
-- helper function
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- general mappings
-- make Y work like D or C
map("n", "Y", "y$")

-- buffer switching
map("n", "gb", ":buffer *")

-- quick search/replace
map("n", "<Space>ip", [[:'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/]])
map("n", "<Space><Space>", [[:%s/\<<C-r>=expand('<cword>')<CR>\>/]])

-- quick change
map("n", "cn", [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]])
map("n", "cN", [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]])

-- better j and k
map("n", "j", "v:count ? 'j' : 'gj'", {expr = true})
map("n", "k", "v:count ? 'k' : 'gk'", {expr = true})

-- repeat last edit n times
map("n", ".", [[:<C-u>execute "norm! " . repeat(".", v:count1)<CR>]])

-- command palette
map("n", [[<C-p>]], [[:Telescope command_palette<CR>]])


-- autocommands
-- return to last edit position when opening files
vim.cmd [[
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
]]

-- disable auto commenting on newlines
vim.cmd [[
    autocmd FileType * set formatoptions-=c formatoptions-=r formatoptions-=o
]]

-- change line numbers depending on vim mode
vim.cmd [[
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
]]


-- colorscheme
vim.opt.termguicolors = true
vim.o.background = "light"
vim.cmd("colorscheme gruvbox")
vim.cmd [[
    hi Normal guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE ctermbg=NONE
    hi GitSignsAdd guibg=NONE ctermbg=NONE
    hi GitSignsChange guibg=NONE ctermbg=NONE
    hi GitSignsDelete guibg=NONE ctermbg=NONE
]]

