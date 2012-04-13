" $Id$
"
" Maintainer:   Tzeng Yuxio <tzengyuxio at gmail dot com>
" Last Change:  2012 Apr 12
"
" To use it, copy it to
"     for Unix and OS X: $HOME/.vimrc
"  for MS-DOS and Win32: $HOME\_vimrc or $VIM\_vimrc

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible               " be iMproved

"-----------------------------------------------------------------------------
" Configure bundles
"-----------------------------------------------------------------------------

filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mattn/calendar-vim'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'tangledhelix/vim-octopress'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
" vim-scripts repos
" non github repos

filetype indent plugin on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"-----------------------------------------------------------------------------
" Setting options 
"-----------------------------------------------------------------------------

set backspace=indent,eol,start

set nobackup      " do not keep a backup file
set noswapfile
set nowritebackup " Make a backup before overwriting a file.

" Can be overruled by using "\c" or "\C" in the pattern. ex: \/Cfoobar
set ignorecase    " ignore case when searching
set incsearch     " do incremental searching
set hlsearch      " highlight search things

" Don't use Ex mode, use Q for formatting
map Q gq

set showmatch     " show matching bracets"

set hidden        " change buffer without saving

" wrap when a line is longer than window size, and insert no `endl'
set textwidth=0
set wrap
set linebreak

" omni complete
set completeopt=longest,menu

"-----------------------------------------------------------------------------
" Indent
"-----------------------------------------------------------------------------

" indent switches
set autoindent    " ai
"set smartindent  " si
"set cindent      " cin - $VIMRUNTIME/indent/c.vim (cpp.vim) has included this
"set copyindent   " ci  - ci means copyindent, not cindent

" tabstop options
"   default : ts=8 sts=0 sw=8 noet nosta
"   python  : ts=4 sw=4 sta si et
"-----------------------------------------
"  ts  : tabstop
"  sts : softtabstop
"  sw  : shiftwidth
"  et  : expandtab
"  sta : smarttab
"  tw  : textwidth
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd FileType vim              setlocal ts=2 sw=2 et
autocmd FileType html,css         setlocal ts=2 sw=2 et
autocmd FileType javascript,json  setlocal ts=2 sw=2 et
autocmd FileType c,cpp            setlocal ts=4 sw=4 et
autocmd FileType java,php         setlocal ts=4 sw=4 et
autocmd FileType python           setlocal ts=8 sw=4 et tw=79

"-----------------------------------------------------------------------------
" Language and Localization
"-----------------------------------------------------------------------------

" vim encoding and file encoding list
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,japan,prc,taiwan,latin1

" file and terminal encoding
set fileencoding=utf-8
set termencoding=utf-8

" fix the gui menu encoding problem
if has("gui_win32")
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim
endif

"-----------------------------------------------------------------------------
" Syntax Highlighting
"-----------------------------------------------------------------------------

syntax on
map <F6> :<C-U>noh<CR>
if isdirectory($HOME."/.vim/bundle/vim-colors-solarized/")
  if has('gui_running')
    set background=light
  else
    let g:solarized_termcolors=256
    set background=dark
  endif
  colorscheme solarized
else
  set background=dark
  colorscheme desert
endif

"-----------------------------------------------------------------------------
" Colors, Fonts and Gui
"-----------------------------------------------------------------------------

" Text User Interface
set ruler       " show the cursor position all the time
set number      " show line number
set cmdheight=2 " the height of command bar is 2 lines
set showcmd     " display incomplete commands
set showtabline=2 " always display tab page labels

" Always show the status line
set laststatus=2

" Graphic User Interface
if has("gui_running")
  autocmd GUIEnter * winpos 0 0 | set lines=999 columns=9999
  set guifont=Dina:h10:cANSI,Consolas:h14:cANSI,Monaco:h14
  set guioptions-=m "Remove menubar"
  set guioptions-=T "Remove toolbar"
endif

"-----------------------------------------------------------------------------
" Key Mapping
"-----------------------------------------------------------------------------

" Don't use ALT keys for menus.
set winaltkeys=no

nmap <F2> a<C-R>=strftime("%c")<CR><Esc>
imap <F2> <C-R>=strftime("%c")<CR>
nmap <S-F2> a<C-R>=strftime("%Y/%m/%d %H:%M:%S")<CR><Esc>
imap <S-F2> <C-R>=strftime("%Y/%m/%d %H:%M:%S")<CR>

" open new tab as in firefox
nnoremap <C-T> :tabnew<CR>
inoremap <C-T> <Esc>:tabnew<CR>
" C-W is used for vim window operations, not suggest to map
"map <C-W> :tabclose<CR>

" switch between buffers
nnoremap <C-Tab>   :bn<CR>
nnoremap <C-S-Tab> :bp<CR>

" move between windows
noremap <C-Up>    <C-W>k
noremap <C-Down>  <C-W>j
noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l

" close tab, buffer or window
noremap <Leader>cb :bd<CR>
noremap <Leader>ct :tabclose<CR>
noremap <Leader>cw <C-W>c
" close all others, but keep only current
noremap <Leader>ot :tabonly<CR>
noremap <Leader>ow <C-W>o

" Reference for one control in different mode.
"noremap <C-Tab> <C-W>w
"inoremap <C-Tab> <C-O><C-W>w
"cnoremap <C-Tab> <C-C><C-W>w
"onoremap <C-Tab> <C-C><C-W>w

" Press ENTER to start typing commands, just like online-game. ;)
map <CR> :

" line movement (use mark `m' for cursor position)
nmap <M-Up>   mm:move .-2<CR>`m
nmap <M-Down> mm:move .+1<CR>`m
imap <M-Up>   <Esc>mm:move .-2<CR>`ma
imap <M-Down> <Esc>mm:move .+1<CR>`ma
vmap <M-Up>   :move '<-2<CR>gv
vmap <M-Down> :move '>+1<CR>gv
vmap <S-Tab>  mm<`m:<C-U>exec "normal ".&shiftwidth."h"<CR>mmgv`m
vmap <Tab>    mm>`m:<C-U>exec "normal ".&shiftwidth."l"<CR>mmgv`m
" easy version without keeping cursor position
"vmap <Tab>    >gv
"vmap <S-Tab>  <gv

"-----------------------------------------------------------------------------
" Auto Commands
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" Plugin Configurations
"-----------------------------------------------------------------------------

let g:Powerline_symbols = 'unicode'

