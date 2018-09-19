"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/threetreeslight/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(expand("$HOME/.cache/dein"))
  call dein#begin(expand("$HOME/.cache/dein"))

  " Let dein manage dein
  " Required:
  call dein#add(expand("$HOME/.cache/dein/repos/github.com/Shougo/dein.vim"))

  " Add or remove your plugins here:
  let g:rc_dir = expand('~/.vim/rc')
  call dein#load_toml(g:rc_dir . '/snippet.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/powerline.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/unite.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/git.toml', {'lazy': 0})
  " call dein#load_toml(g:rc_dir . '/syntax.toml', {'lazy': 1})
  call dein#load_toml(g:rc_dir . '/utility.toml', {'lazy': 0})
  " " call dein#load_toml(g:rc_dir . '/complete.toml', {'lazy': 0})
  " call dein#load_toml(g:rc_dir . '/ruby.toml', {'lazy': 1}) " Need fix it

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  " Required:
  call dein#end()
  call dein#save_state()
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
" display
"-------------------------
set colorcolumn=120 " colorcolumn
set cmdheight=2 "cmd adn message display space line hiehgt
set laststatus=2 "Always display the status line
set mouse=a "Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue
set nowrap "nowrap sentence
set number "Display line numbers on the left
set ruler "Display the cursor position
set showmode "Show vim mode such as insert, visual
set showcmd "Show partial commands in the last line of the screen
set title "Show file title
set visualbell "Use visual bell instead of beeping when doing something wrong
set vb t_vb= " disable screen bell

" invisible charactor
set list " show invisible charactor
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:< " invisible charactor visual setting

" tab, indent
set smartindent
set ts=2 sw=2 sts=0
set expandtab
set backspace=indent,eol,start "Allow backspacing over autoindent, line breaks and start of insert action

" colorscheme
syntax enable
colorscheme desert

" escape Highlight
nmap <silent> <Esc><Esc> :nohlsearch<CR>

"-------------------------
" backup
"-------------------------
set nobackup
set noswapfile
set nowritebackup

"-------------------------
" cursor
"-------------------------
" display lines downward, upword
noremap j gj
noremap k gk

"selection line by double v
vnoremap v $h

"-------------------------
" insert
"-------------------------
set backspace=indent,eol,start " backspace can delete any item
set hidden "alternative close. Use undo history
set infercase "undifferentiated compl
set matchpairs& matchpairs+=<:> "add matchtipes <>
set nostartofline "Stop certain movements from always going to the first character of a line.
set shiftround "<,>,indent width is shiftwidth
set showmatch
set switchbuf=useopen "open buffer alternative new one

" bracket
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

"-------------------------
" search
"-------------------------
set hlsearch   "Highlight search result
set incsearch  "incrimental search
set ignorecase "Use case insensitive search, except when using capital letters
set smartcase  "undifferentiated
set wrapscan

"escape /,?
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'))

"-------------------------
" tab
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
" yank
"-------------------------
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
  set clipboard& clipboard+=unnamed
endif
" share Mac OS X ClipBoard
if has('mac')
  vmap <C-c> :w !pbcopy<cr><cr>
endif

"-------------------------
" ctags
"-------------------------
set tags=./tags

"-------------------------
" complement
"-------------------------
set wildmenu "Better command-line completion
" autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"-------------------------
" utility functions
"-------------------------
" echomsg string("Register Utility Functions")
function! s:TrimTailSpace()
  let l:save_cursor = getpos(".")
  silent! execute ':s/\s\+$//'
  call setpos('.', l:save_cursor)
endfunction
command! -range=% TrimTailSpace call <SID>TrimTailSpace()
