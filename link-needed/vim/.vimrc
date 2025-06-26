syntax on

" 不与vi兼容
set nocompatible

set number
set relativenumber
set cursorline

" 2 space tab
set tabstop=2
set shiftwidth=2
set expandtab

set autoindent
filetype indent on
filetype plugin on

" 显示模式
set showmode
set showcmd

set mouse=a

" 设置文件编码格式为utf-8
set encoding=utf-8

" 256色
set t_Co=256

" 自动折行
set wrap

" 显示状态栏
set laststatus=2

" 高亮搜索结果
set hlsearch
" 高亮()匹配
set showmatch

" 保留修改记录
set undofile
" set backupdir=~/.vim/.backup//  
" set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//

" 文件监视
set autoread

" 命令行补全
set wildmenu
set wildmode=longest:list,full

let mapleader = " "

"""
""" Useful Key Map
"""
nnoremap cd 0D
nnoremap cnh :nohl<CR>
nnoremap c<space> o<esc>

nnoremap <c-j> 5j
nnoremap <c-k> 5k
nnoremap <c-h> 5h
nnoremap <c-l> 5l

vnoremap <c-j> 5j
vnoremap <c-k> 5k
vnoremap <c-h> 5h
vnoremap <c-l> 5l

xnoremap <c-j> 5j
xnoremap <c-k> 5k
xnoremap <c-h> 5h
xnoremap <c-l> 5l

nnoremap csh :set nosplitright<CR>:vsplit<CR>
nnoremap csl :set splitright<CR>:vsplit<CR>
nnoremap csj :set splitbelow<CR>:split<CR>
nnoremap csk :set nosplitright<CR>:split<CR>
nnoremap <LEADER>h <C-w>h
nnoremap <LEADER>l <C-w>l
nnoremap <LEADER>j <C-w>j
nnoremap <LEADER>k <C-w>k
nnoremap <LEADER><left> :vertical resize-5<CR>
nnoremap <LEADER><right> :vertical resize+5<CR>
nnoremap <LEADER><down> :res +5<CR>
nnoremap <LEADER><up> :res -5<CR>

nnoremap ct :tabe<CR>
nnoremap <LEADER>H :-tabnext<CR>
nnoremap <LEADER>L :+tabnext<CR>
nnoremap <LEADER>J :-tabmove<CR>
nnoremap <LEADER>K :+tabmove<CR>

vnoremap < <gv
vnoremap > >gv

vnoremap J :m >+1<CR>gv=gv
vnoremap K :m <-2<CR>gv=gv
xnoremap J :m >+1<CR>gv=gv
xnoremap K :m <-2<CR>gv=gv

map y "+y

"""
""" Just Like Plugin
"""

" File Tree ==> Like yazi
let g:netrw_banner=0 " 禁用没用的横幅
let g:netrw_winsize=25 " 初始窗口大小为25%
let g:netrw_liststyle=3 " 使用树状模式
let g:netrw_altv=1 " 分割窗口时默认在右边
let g:netrw_browse_split=4 " enter时在上一个窗口打开
nnoremap <LEADER>cy :Vex<CR>

" Auto Cmp
inoremap <c-j> <c-n>
inoremap <c-k> <c-p>
set omnifunc=syntaxcomplete#Complete
