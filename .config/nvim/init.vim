filetype plugin indent on
syntax on

call plug#begin('~/.config/nvim/plugged')

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'romainl/vim-cool'
  Plug 'dylanaraps/wal.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'tweekmonster/startuptime.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'puremourning/vimspector'
  Plug 'stevearc/vim-arduino'
  Plug 'coddingtonbear/neomake-platformio'
  " Plug 'lifepillar/vim-mucomplete'
  " Plug 'neovim/nvim-lsp'
  " Plug 'nvim-lua/diagnostic-nvim'
  " Plug 'nvim-lua/completion-nvim'

call plug#end()


" various settings
set clipboard+=unnamedplus
set backspace=indent,eol,start
set omnifunc=v:lua.vim.lsp.omnifunc
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
" tab for trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

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

" Automatically close preview window during completions
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

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

" arduino stuff
let g:arduino_cmd = '/Applications/Arduino.app/Contents/MacOS/Arduino'


" colorscheme
colorscheme wal
