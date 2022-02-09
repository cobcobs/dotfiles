-- packer.nvim bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- startup and add plugins
require("packer").startup(function(use)
    use {"wbthomason/packer.nvim"}
    use {"lewis6991/impatient.nvim"}
    use {"neovim/nvim-lspconfig"}
    use {"echasnovski/mini.nvim"}
    use {"hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-buffer", event = "InsertEnter"}
    use {"hrsh7th/cmp-path", event = "InsertEnter"}
    use {"hrsh7th/cmp-nvim-lua", event = "InsertEnter"}
    use {"hrsh7th/cmp-nvim-lsp", event = "InsertEnter"}
    use {"L3MON4D3/LuaSnip", event = "InsertEnter"}
    use {"saadparwaiz1/cmp_luasnip", event = "InsertEnter"}
    use {"kdheepak/cmp-latex-symbols", event = "InsertEnter"}
    use {"onsails/lspkind-nvim"}
    use {"lewis6991/gitsigns.nvim"}
    use {"nvim-telescope/telescope.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"lukas-reineke/indent-blankline.nvim"}
    use {"romainl/vim-cool", event = "CmdlineEnter"}
    use {"jacob-ethan/olivia.vim", event = "VimEnter"}

    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- setup plugins
require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("gitsigns").setup {
    yadm = {
        enable = true
  },
}
require("indent_blankline").setup()
require("telescope").setup()

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
vim.cmd("colorscheme olivia")

