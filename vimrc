" $Id$
"
" Maintainer:   Tzeng Yuxio <tzengyuxio at gmail dot com>
" Last Change:  2011 Dec 30
"
" To use it, copy it to
"     for Unix and OS X: $HOME/.vimrc
"  for MS-DOS and Win32: $HOME\_vimrc or $VIM\_vimrc

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" when .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source $MYVIMRC

" Runtime path manipulation
call pathogen#infect()


"=============================================================================
" General Options
"=============================================================================
set backspace=indent,eol,start

set nobackup      " do not keep a backup file
set noswapfile
set nowritebackup " Make a backup before overwriting a file.

set history=50    " keep 50 lines of command line history

" Can be overruled by using "\c" or "\C" in the pattern. ex: \/Cfoobar
set ignorecase    " ignore case when searching
set incsearch     " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" favorite filetype
set fileformats=unix,dos,mac
filetype plugin indent on

set showmatch     " show matching bracets"
set matchtime=3   " how many tenths of a second to blink (default 5)

set hidden        " change buffer without saving
set showtabline=2 " always display tab page labels

" wrap when a line is longer than window size, and insert no `endl'
set textwidth=0
set wrap
set linebreak

" omni complete
set completeopt=longest,menu

" indent switches
set autoindent  " ai
set smartindent " si
"set cindent    " cin - $VIMRUNTIME/indent/c.vim (cpp.vim) has included this
"set copyindent " ci  - ci means copyindent, not cindent

" tabstop options
"   default : ts=8 sts=0 sw=8 noet nosta
"   python  : ts=4 sw=4 sta si et
"-----------------------------------------------------------------------------
"  ts  : tabstop
"  sts : softtabstop
"  sw  : shiftwidth
"  et  : expandtab
"  sta : smarttab
"  tw  : textwidth
autocmd FileType vim              setlocal ts=2 sw=2 et
autocmd FileType html,javascript  setlocal ts=2 sw=2 et
autocmd FileType c,cpp            setlocal ts=4 sw=4 et
autocmd FileType java,php         setlocal ts=4 sw=4 et
autocmd FileType python           setlocal ts=8 sw=4 et tw=79


"=============================================================================
" Language and Localization
"=============================================================================
if has("multi_byte")
  " locale lanuage
  if has("win32")
    language chinese_taiwan.950
  else
    language zh_TW.UTF-8
  endif
  language messages zh_TW.utf-8

  " vim encoding and file encoding list
  set encoding=utf-8
  set fileencodings=ucs-bom,utf-8,japan,prc,taiwan,latin1

  " file and terminal encoding
  if has("unix") || has("gui_running")
    set fileencoding=utf-8
    set termencoding=utf-8
  else
    set fileencoding=taiwan
    set termencoding=taiwan
  endif

  " fix the gui menu encoding problem
  if has("gui_win32")
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
  endif
endif


"=============================================================================
" Syntax Highlighting
"=============================================================================
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch          " highlight search things
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
    colorscheme desert
    " omni menu colors
    hi Pmenu    cterm=NONE ctermfg=7 ctermbg=5 gui=NONE guifg=#d3d7cf guibg=#3465a4
    hi PmenuSel cterm=NONE ctermfg=0 ctermbg=7 gui=bold guifg=#eeeeec guibg=#f57900
  endif
endif


"=============================================================================
" Colors, Fonts and Gui
"=============================================================================
" Text User Interface
set ruler       " show the cursor position all the time
set number      " show line number
set cmdheight=2 " the height of command bar is 2 lines
set showcmd     " display incomplete commands

" Graphic User Interface
if has("gui_running")
  autocmd GUIEnter * winpos 0 0 | set lines=999 columns=9999
  set guifont=Dina:h10:cANSI,Consolas:h14:cANSI,Monaco:h14
  set guioptions-=m "Remove menubar"
  set guioptions-=T "Remove toolbar"
endif


"=============================================================================
" Status Bar
"=============================================================================
function! LoadStatusBar()
  "Always show the status line
  set laststatus=2

  "Format the statusline
  if has("statusline")
    " Custom color usage
    " ------------------
    " User1 : buffer number
    " User2 : flag of Modified and Readonly
    " User3 : filename
    " User4 : type of file
    " User5 : current position (line and column) highlight
    hi StatusLine   gui=NONE guifg=#2e3436 guibg=#eeeeec
    hi StatusLineNC gui=NONE guifg=#888a85 guibg=#babdb6
    hi User1        gui=NONE guifg=#000000 guibg=#eeeeec
    hi User2        gui=NONE guifg=#edd400 guibg=#ef2929
    hi User3        gui=bold guifg=#3465a4 guibg=#eeeeec
    hi User4        gui=NONE guifg=#4e9a06 guibg=#eeeeec
    hi User5        gui=NONE guifg=#f57900 guibg=#eeeeec
    if &t_Co > 255
      hi StatusLine   cterm=NONE ctermfg=8  ctermbg=15
      hi StatusLineNC cterm=NONE ctermfg=7  ctermbg=8
      hi User1        cterm=NONE ctermfg=0  ctermbg=15
      hi User2        cterm=NONE ctermfg=11 ctermbg=9
      hi User3        cterm=bold ctermfg=25 ctermbg=15
      hi User4        cterm=NONE ctermfg=2  ctermbg=15
      hi User5        cterm=NONE ctermfg=9  ctermbg=15
    endif

    set statusline=%1*[#%02n]%*%2*%([%M%R]%)%*\ %3*%t%*\ %4*%y%*\ \|
    set statusline+=\ %{getfsize(expand(\"%:p\"))}\ B\ \|
    if &columns > 100
      "set statusline+=%<
      set statusline+=\ %{strftime(\"%c\",\ getftime(expand(\"%:p\")))}\ \|
    endif
    set statusline+=%=\|
    if &columns > 125
      set statusline+=\ @\ %{getcwd()}\ \|
    endif
    set statusline+=\ POS:\ %o\ (%5*%l%*/%L,%5*%c%*)\ \|\ %{&fenc}\ \|\ %{&ff}\ \|\ %P\ 
  endif
endfunction
call LoadStatusBar()
autocmd VimResized * call LoadStatusBar()


"=============================================================================
" Key Mapping
"=============================================================================
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

" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/VimTip171
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" bash style keyboard shortcuts
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

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

" ALT Mapping, please press <Ctrl-Q><Alt-{Key}>
" followings are <M-K>, <M-J>, <M-H>, <M-L>
nmap ë <M-Up>
nmap ê <M-Down>
nmap è mm<<`m:exec "normal ".&shiftwidth."h"<CR>
nmap ì mm>>`m:exec "normal ".&shiftwidth."l"<CR>
imap ë <M-Up>
imap ê <M-Down>
imap è <Esc>mm<<`m:exec "normal ".&shiftwidth."h"<CR>a
imap ì <Esc>mm>>`m:exec "normal ".&shiftwidth."l"<CR>a
vmap ë <M-Up>
vmap ê <M-Down>
vmap è <S-Tab>
vmap ì <Tab>
vmap <C-K> <M-Up>
vmap <C-J> <M-Down>
vmap <C-H> <S-Tab>
vmap <C-L> <Tab>

" with <Leader>
map <Leader>cd :cd %:p:h<CR>

" auto close
inoremap ( ()<Esc>:let rightclose=")"<CR>i
inoremap { {}<Esc>:let rightclose="}"<CR>i
inoremap [ []<Esc>:let rightclose="]"<CR>i
"inoremap < <><Esc>:let rightclose=">"<CR>i
inoremap ' ''<Esc>:let rightclose="'"<CR>i
"inoremap " ""<Esc>:let rightclose='"'<CR>i
inoremap ` ``<Esc>:let rightclose="`"<CR>i
" shortcut <M-L> for quickly get out of pairs
imap ì <Esc>:exec "normal f".rightclose<CR>a

" auto surround
vnoremap <Leader>( <Esc>`<i(<Esc>`>a)<Esc>
vnoremap <Leader>) <Esc>`<i( <Esc>`>a )<Esc>
vnoremap <Leader>{ <Esc>`<O{<Esc>`>o}<Esc>
vnoremap <Leader>} >><Esc>`<O{<Esc>`>o}<Esc><<
vnoremap <Leader>[ <Esc>`<i[<Esc>`>a]<Esc>
vnoremap <Leader>] <Esc>`<i[ <Esc>`>a ]<Esc>
"vnoremap <Leader>< <Esc>`<i<<Esc>`>a><Esc>
vnoremap <Leader>> <Esc>`<i< <Esc>`>a ><Esc>
vnoremap <Leader>' <Esc>`<i'<Esc>`>a'<Esc>
vnoremap <Leader>" <Esc>`<i"<Esc>`>a"<Esc>
vnoremap <Leader>` <Esc>`<i`<Esc>`>a`<Esc>


"=============================================================================
" Auto Commands
"=============================================================================
" Restore cursor to file position in previous editing session
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
"-----------------------------------------------------------------------------
" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n$HOME/.viminfo
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" automatically removing all trailing whitespace
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
"autocmd BufWritePre * :%s/\s\+$//e


"=============================================================================
" Plugin Configurations
"=============================================================================
