" dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" dein plugin install path
let s:dein_dir = expand('~/.cache/dein')
" dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" if dein.vim does not exist, clone it
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" dein load
if dein#load_state(s:dein_dir)
  " Required:
  call dein#begin(s:dein_dir)

  let g:rc_dir = expand('~/.vim/rc')
  call dein#load_toml(g:rc_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/snippet.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/display.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/unite.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/git.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/utility.toml', {'lazy': 0})
  " call dein#load_toml(g:rc_dir . '/complete.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/syntax.toml', {'lazy': 1})
  call dein#load_toml(g:rc_dir . '/ruby.toml', {'lazy': 1}) " Need fix it

  " Required:
  call dein#end()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"-------------------------
"search
"-------------------------
set hlsearch   "Highlight searche
set incsearch  "incrimental search
set ignorecase "Use case insensitive search, except when using capital letters
set smartcase  "undifferentiated
set wrapscan

"escape /,?
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'))

"-------------------------
" tag
"-------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " already show tab line

nnoremap [Tag] <Nop>
nmap t [Tag]

" create new tab
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" close tab
map <silent> [Tag]x :tabclose<CR>
" next tab
map <silent> [Tag]n :tabnext<CR>
" previous tab
map <silent> [Tag]p :tabprevious<CR>

"-------------------------
" edit
"-------------------------
set shiftround "<,>,indent width is shiftwidth
set infercase "undifferentiated compl
set hidden "alternative close. Use undo history
set switchbuf=useopen "open buffer alternative new one
set showmatch
set matchpairs& matchpairs+=<:> "add matchtipes <>

"backspace can delete any item
set backspace=indent,eol,start

" Yank
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
  set clipboard& clipboard+=unnamed
endif
" share Mac OS X ClipBoard
vmap <C-c> :w !pbcopy<cr><cr>

"backups
set nobackup
set noswapfile
set nowritebackup

" Run :FixWhitespace to remove end of line white space
function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

"-------------------------
" ctags
"-------------------------
set tags=./tags

"-------------------------
" display
"-------------------------
set showmode
set showcmd "Show partial commands in the last line of the screen
set title
set number "Display line numbers on the left
set ruler "Display the cursor position
set laststatus=2 "Always display the status line
set cmdheight=2 "cmd line hiehgt
set visualbell "Use visual bell instead of beeping when doing something wrong
set nowrap "nowrap sentence

" invisible charactor visual setting
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
match JpSpace /　/

" negative screen bell
set vb t_vb=

" colorscheme
syntax enable
colorscheme solarized

" tab, indent
set smartindent
set ts=2 sw=2 sts=0
set expandtab
set backspace=indent,eol,start "Allow backspacing over autoindent, line breaks and start of insert action

" colorcolumn
set colorcolumn=120

"-------------------------
" keybind & mcro
"-------------------------
" escape
imap <C-j> <C-[>

" escape Highlight
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

"selection line by double v
vnoremap v $h

" bracket
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" trim space
nmap <C-t> :%s/ *$//g<CR><Esc><Esc>

set nostartofline "Stop certain movements from always going to the first character of a line.
set mouse=a "Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue

"-------------------------
" complement
"-------------------------
set wildmenu "Better command-line completion

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
