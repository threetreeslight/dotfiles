"-------------------------
" plugin
"-------------------------
set nocompatible " be iMproved 
filetype off     " Required!

"neobundle
if has('vim_starting')
  set runtimepath+=~/.vim/neobundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', {
    \'build' : {
    \   'windows' : 'make -f make_mingw32.mak',
    \   'cygwin'  : 'make -f make_cygwin.mak',
    \   'mac'     : 'make -f make_mac.mak',
    \   'unix'    : 'make -f make_unix.mak',
    \   },
    \}

"utlity
NeoBundle 'Shougo/unite.vim'
NeoBundle 'sakuraiyuta/commentout.vim' "commentout alias command
NeoBundle 'scrooloose/nerdtree' "directory tree
NeoBundle 'Shougo/vimfiler' "filer
NeoBundle 'nathanaelkane/vim-indent-guides' "indent syntax
NeoBundle 'altercation/vim-colors-solarized' "color schema
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'} "for pwoerline

"comple
NeoBundle 'vim-scripts/AutoComplPop'
NeoBundle 'Shougo/neocomplcache' "comple
NeoBundle 'm2ym/rsense' "ruby comple
NeoBundle 'Shougo/neocomplcache-rsense.vim' "rsense for neocomplcache

"compile
NeoBundle 'thinca/vim-quickrun'

"git
NeoBundle 'airblade/vim-gitgutter'

"ruby, rails
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'ujihisa/unite-rake' "Unite
NeoBundle 'basyura/unite-rails' "Unite
NeoBundle 'vim-scripts/dbext.vim'
NeoBundle 'digitaltoad/vim-jade'
"html5
NeoBundle 'othree/html5.vim.git'
"css,less,sass
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'skammer/vim-css-color.git'
NeoBundle 'groenewege/vim-less'
NeoBundle 'cakebaker/scss-syntax.vim'
"js,node
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'kchmck/vim-coffee-script' 


filetype plugin indent on "required!

"-------------------------
" display
"-------------------------
set showmode
set showcmd "Show partial commands in the last line of the screen
set showmatch
set hidden "Allows you to switch from an unsaved buffer without saving it first.
set title
set number "Display line numbers on the left
set ruler "Display the cursor position 
set laststatus=2 "Always display the status line
set cmdheight=2 "cmd line hiehgt
set visualbell "Use visual bell instead of beeping when doing something wrong
set nowrap "nowrap sentence

"colorscheme
syntax enable
set background=dark
colorscheme solarized

"tab, indent
set expandtab
set ts=2 sw=2 sts=0
set smartindent 
set backspace=indent,eol,start "Allow backspacing over autoindent, line breaks and start of insert action

"Indent Syntax (vim indent guids)
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=darkblue
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=yellow ctermbg=darkcyan
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

"invisible charactor visual setting
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
match JpSpace /　/

"NERDTree auto OPEN
let NERDTreeShowHidden = 1
let file_name = expand("%")
if has('vim_starting') &&  file_name == ""
  autocmd VimEnter * NERDTree ./
endif

"Vimfiler use :e, help a
let g:vimfiler_as_default_explorer = 1

"-------------------------
" utility
"-------------------------
set showmode
" Use ClipBoard
vmap <C-c> :w !pbcopy<cr><cr>

"escape
imap <C-j> <C-[>
imap <C-k> <C-m>
"bracket
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

set nostartofline "Stop certain movements from always going to the first character of a line.
set mouse=a "Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue

"backups
set nobackup
set noswapfile

"-------------------------
"search
"-------------------------
set nohlsearch "Highlight searche
set noincsearch
set ignorecase "Use case insensitive search, except when using capital letters
set smartcase
set wrapscan

"-------------------------
"compl
"-------------------------
set wildmenu "Better command-line completion

""neocomplecache
"
let g:acp_enableAtStartup = 0 "Disable AutocomplPop
let g:neocomplcache_enable_at_startup = 1 "Use neocomplcache
let g:neocomplcache_enable_smart_case = 1 " Use smartcase.

"Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
   \ 'default' : '',
   \ 'vimshell' : $HOME.'/.vimshell_hist',
   \ 'scheme' : $HOME.'/.gosh_completions'
   \ }

"Enable omni completion.
autocmd FileType css,scss,sass,less setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript,coffee setlocal omnifunc=nodejscomplete#CompleteJS
"Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.javascript = 'nodejscomplete#CompleteJS'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or if we want to try autocompletion
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<TAB>"
  else
    if pumvisible()
      return "\<C-N>"
    else
      return "\<C-N>\<C-P>"
    end
  endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"-------------------------
"Unite
"-------------------------
let g:unite_enable_start_insert=0 "start by insert mode

"buffer list
noremap <C-U><C-B> :Unite buffer<CR>
"file list
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
"recent access file list
noremap <C-U><C-R> :Unite file_mru<CR>
"register list
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
"file and buffer list
noremap <C-U><C-U> :Unite buffer file_mru<CR>

"function! UniteRailsSetting()
  nnoremap <buffer><C-H><C-H><C-H>  :<C-U>Unite rails/view<CR>
  nnoremap <buffer><C-H><C-H>       :<C-U>Unite rails/model<CR>
  nnoremap <buffer><C-H>            :<C-U>Unite rails/controller<CR>

  nnoremap <buffer><C-H>c           :<C-U>Unite rails/config<CR>
  nnoremap <buffer><C-H>d           :<C-U>Unite rails/db<CR>
  nnoremap <buffer><C-H>l           :<C-U>Unite rails/lib<CR>
" endfunction
"aug MyAutoCmd
"  au User Rails call UniteRailsSetting()
"aug END

"quite Unite
au FileType unite nnoremap <silent> <buffer> <C-j><C-j> :q<CR>
au FileType unite inoremap <silent> <buffer> <C-j><C-j> <ESC>:q<CR>


