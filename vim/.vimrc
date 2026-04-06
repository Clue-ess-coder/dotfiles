set nocompatible
filetype plugin indent on
syntax enable

set number
set relativenumber
set cursorline
set showcmd
set wildmenu
set lazyredraw
set showmatch
set ruler
set laststatus=2
set signcolumn=yes
set colorcolumn=120
set list
set listchars=tab:→\ ,trail:·,nbsp:␣

set background=dark
set termguicolors
colorscheme slate

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set nowrap
set linebreak

set incsearch
set hlsearch
set ignorecase
set smartcase
set magic

set encoding=utf-8
set fileencoding=utf-8
set hidden
set autoread
set nobackup
set noswapfile
set undofile
set undodir=~/.vim/undo//

set updatetime=50
set timeoutlen=300
set ttimeoutlen=10

set splitbelow
set splitright

set scrolloff=15
set sidescrolloff=8

set foldmethod=indent
set foldlevelstart=99
set foldenable

if has('clipboard')
  set clipboard=unnamedplus
endif

let mapleader=" "

nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>q :q<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Esc> :nohlsearch<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>bd :bdelete!<CR>
nnoremap <leader>bn :enew<CR>

nnoremap j gj
nnoremap k gk

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap n nzzzv
nnoremap N Nzzzv

"nnoremap <leader>rw :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

nnoremap <leader>s :vsplit<CR>
nnoremap <leader>- :split<CR>

" nnoremap <leader>ml <C-w>H
" nnoremap <leader>md <C-w>J
" nnoremap <leader>mu <C-w>K
" nnoremap <leader>mr <C-w>L

nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

nnoremap <leader>tt :terminal<CR>
nnoremap <leader>ts :split \| terminal<CR>
nnoremap <leader>tv :vsplit \| terminal<CR>

nnoremap vag ggVG

nnoremap x "_x

nnoremap <leader>rf :source %<CR>

vnoremap < <gv
vnoremap > >gv
vnoremap j gj
vnoremap k gk
vnoremap <leader>p "_dP
vnoremap p "_dp

vnoremap <A-k> :m '<-2<CR>gv=gv
vnoremap <A-j> :m '>+1<CR>gv=gv

augroup vimrc_autocmds
    autocmd!

    autocmd BufWritePre * :%s/\s\+$//e

    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype !~# 'commit' |
        \   exe "normal! g'\"" |
        \ endif

    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
        \ if mode() !=# 'c' | checktime | endif

    autocmd BufWritePre * call mkdir(fnamemodify(expand('<afile>'), ':p:h'), 'p')

    autocmd VimResized * wincmd =

    autocmd BufEnter,WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline

    autocmd TerminalOpen * setlocal nonumber norelativenumber | startinsert

    autocmd VimEnter * if filereadable('.vim') | source .vim | endif
augroup END

augroup filetypes
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType javascript,typescript,json setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType html,css,scss setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType markdown,text,gitcommit setlocal wrap linebreak spell spelllang=en_us
    autocmd FileType gitcommit setlocal textwidth=72 colorcolumn=72
    autocmd BufNewFile,BufRead *.jsx setfiletype javascriptreact
    autocmd BufNewFile,BufRead *.tsx setfiletype typescriptreact
    autocmd BufNewFile,BufRead .env*,*.env setfiletype sh
augroup END

set mouse=a

set completeopt=menu,menuone,noselect
set pumheight=10
set shortmess+=c

set backspace=start,eol,indent

set isfname+=@-@
set history=1000
set wildmode=list:longest,full

if has('terminal')
    tnoremap <Esc><Esc> <C-\><C-n>
endif
