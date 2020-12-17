filetype plugin indent on
syntax on

call plug#begin('~/.config/nvim/plugged')

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'romainl/vim-cool'
  Plug 'dylanaraps/wal.vim'
  Plug 'JuliaEditorSupport/julia-vim'
  Plug 'tmsvg/pear-tree'
  Plug 'lifepillar/vim-mucomplete'

call plug#end()


" various settings
set clipboard+=unnamedplus
set backspace=indent,eol,start
set omnifunc=syntaxcomplete#Complete
set hidden
set ignorecase
set smartcase
set noruler
set noshowmode
set noshowcmd
set mouse=a
set number
set relativenumber
set splitbelow splitright
set wildcharm=<C-z>
set cmdheight=1
set scrolloff=5
set shortmess=at
set laststatus=0
set softtabstop=4
set shiftround
set undofile
set undodir=$HOME/.config/nvim/undodir
set completeopt=menuone,noinsert,noselect
set shortmess+=c


" mappings
" Make Y work like D or C
nnoremap Y y$

" Buffer switching
nnoremap gb :buffer *

" Quick search/replace
nnoremap <Space>ip       :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/
nnoremap <Space><Space>  :%s/\<<C-r>=expand('<cword>')<CR>\>/

" Quick change
nnoremap cn /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap cN ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

" Better j and k
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'


" autocommands
" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Disable auto commenting on newlines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" change line numbers
autocmd InsertEnter * :set norelativenumber
autocmd	InsertLeave * :set relativenumber

" c++ stuff
autocmd filetype cpp set mp=g++\ -O2\ -Wall\ --std=c++11\ -Wno-unused-result\ %:r.cpp\ -o\ %:r
autocmd filetype cpp nnoremap <F2> :vs %:r.in <CR>
autocmd filetype cpp nnoremap <F3> :w<CR> :make<CR>
autocmd filetype cpp nnoremap <F4> :!time ./%:r < %:r.in <CR>
autocmd filetype cpp nnoremap <F5> :w <bar> :make <bar> :!time ./%:r < %:r.in <CR>
autocmd filetype cpp setlocal shiftwidth=2 softtabstop=2 expandtab


" colorscheme
colorscheme wal
