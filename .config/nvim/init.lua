-- plugins
-- packer.nvim
require("impatient").enable_profile()
require("packer").startup(function()
  use "wbthomason/packer.nvim"
  use "lewis6991/impatient.nvim"
  use "nathom/filetype.nvim"
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip"
  use "windwp/nvim-autopairs"
  use {"tpope/vim-surround", event = "VimEnter"}
  use {"tpope/vim-commentary", event = "VimEnter"}
  use {"tpope/vim-repeat", event = "VimEnter"}
  use {"romainl/vim-cool", event = "VimEnter"}
  use {"ripxorip/aerojump.nvim", event = "VimEnter"}
  use {"jacob-ethan/olivia.vim", event = "ColorSchemePre"}
end)

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
-- vim.opt.omnifunc = "syntaxcomplete#Complete"
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
vim.opt.shortmess = "at"
vim.opt.laststatus = 0
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("config") .. "/undodir"
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.conceallevel = 2
vim.opt.title = true


-- plugin settings
-- autopairs
require("nvim-autopairs").setup{}

-- lsp stuff
require("lspconfig").pyright.setup{}

-- nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- aerojump.nvim
vim.cmd [[
  let g:aerojump_keymaps = {"<tab>": "AerojumpSelNext", "<s-tab>": "AerojumpSelPrev", "<esc>": "AerojumpExit"}
]]


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

-- plugin mappings
-- better search with / and ?
map("n", "/", "<Plug>(AerojumpSpace)", {noremap = false})
map("n", "?", "<Plug>(AerojumpBolt)", {noremap = false})


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
