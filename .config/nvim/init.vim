filetype plugin indent on
syntax on

call plug#begin('~/.config/nvim/plugged')

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'romainl/vim-cool'
  Plug 'dylanaraps/wal.vim'
  Plug 'tmsvg/pear-tree'
  Plug 'lifepillar/vim-mucomplete'
  Plug 'jpalardy/vim-slime'
  Plug 'JuliaEditorSupport/julia-vim'
  Plug 'mroavi/vim-julia-cell', { 'for': 'julia' }
  Plug 'davidhalter/jedi-vim'
  Plug 'lervag/vimtex'
  Plug 'SirVer/ultisnips'
  Plug 'pechorin/any-jump.vim'
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" settings
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
set conceallevel=2


" plugin settings
" ultisnips
let g:UltiSnipsExpandTrigger = "<f5>"        " Do not use <tab>
let g:UltiSnipsJumpForwardTrigger = "<c-b>"  " Do not use <c-j>
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:ulti_expand_or_jump_res = 0

" vimtex
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'skim'
let g:tex_conceal='abdmg'
let g:vimtex_syntax_conceal = {
	\ 'accents': 1,
	\ 'cites': 1,
	\ 'fancy': 1,
	\ 'greek': 1,
	\ 'math_bounds': 1,
	\ 'math_delimiters': 1,
	\ 'math_fracs': 1,
	\ 'math_super_sub': 1,
	\ 'math_symbols': 1,
	\ 'sections': 1,
	\ 'styles': 1,
	\}

" mucomplete
let g:mucomplete#no_mappings = 1

" plugin functions
fun! TryUltiSnips()
  if !pumvisible() " With the pop-up menu open, let Tab move down
    call UltiSnips#ExpandSnippetOrJump()
  endif
  return ''
endf

fun! TryMUcomplete()
  return g:ulti_expand_or_jump_res ? "" : "\<plug>(MUcompleteFwd)"
endf

" extend completion
imap <expr> <right> mucomplete#extend_fwd("\<right>")

" try to autocomplete snippet first, then completion later
inoremap <plug>(TryUlti) <c-r>=TryUltiSnips()<cr>
imap <expr> <silent> <plug>(TryMU) TryMUcomplete()
imap <expr> <silent> <tab> "\<plug>(TryUlti)\<plug>(TryMU)"
imap <s-tab> <plug>(MUcompleteBwd)

" expand if completed word is a snippet
inoremap <silent> <expr> <plug>MyCR mucomplete#ultisnips#expand_snippet("\<cr>")
imap <cr> <plug>MyCR


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
highlight Comment cterm=italic
