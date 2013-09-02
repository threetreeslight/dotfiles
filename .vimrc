"-------------------------
" plugin
"-------------------------
set nocompatible " be iMproved
filetype off     " Required!

let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = expand('~/.vim/neobundle/neobundle.vim')

if !isdirectory(s:neobundle_root) || v:version < 702
  "if nothing NeoBundle or old version vim, dont use plugin.
  let s:noplugin = 1
else

  "include initialize NeoBundle to runtimepath
  if has('vim_starting')
    execute "set runtimepath+=" . s:neobundle_root
  endif
  call neobundle#rc(s:bundle_root)

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
  NeoBundle 'sakuraiyuta/commentout.vim' "commentout alias command
  NeoBundle 'scrooloose/nerdtree' "directory tree
  "Unite
  NeoBundleLazy 'Shougo/unite.vim', {
        \ 'autoload' : {
        \   'commands' : [ 'Unite' ]
        \ }}
  let s:bundle = neobundle#get('unite.vim')
  function! s:bundle.hooks.on_source(bundle)
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

    "quite Unite
    au FileType unite nnoremap <silent> <buffer> <C-j><C-j> :q<CR>
    au FileType unite inoremap <silent> <buffer> <C-j><C-j> <ESC>:q<CR>
  endfunction

  "filer
  NeoBundleLazy 'Shougo/vimfiler', {
        \   'autoload' : { 'commands' : [ 'VimFilerBufferDir' ] },
        \   'depends' : [ 'Shougo/unite.vim' ]
        \ }
  let s:bundle = neobundle#get('vimfiler')
  function! s:bundle.hooks.on_source(bundle)
    "Vimfiler use :e, help a
    let g:vimfiler_as_default_explorer = 1
  endfunction

  NeoBundle 'nathanaelkane/vim-indent-guides' "indent syntax
  NeoBundle 'altercation/vim-colors-solarized' "color schema
  NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'} "for pwoerline

  "comple
  NeoBundle 'vim-scripts/AutoComplPop'
  NeoBundleLazy 'Shougo/neocomplcache', {
        \ 'autoload' : {
        \   'insert' : 1,
        \ } }
  NeoBundle 'm2ym/rsense' "ruby comple
  NeoBundle 'Shougo/neocomplcache-rsense.vim' "rsense for neocomplcache

  "compile
  NeoBundle 'thinca/vim-quickrun'

  "git
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'tpope/vim-fugitive'
  "vim-fugitive map map
  nnoremap <silent> <Space>gb :Gblame<CR>
  nnoremap <silent> <Space>gd :Gdiff<CR>
  nnoremap <silent> <Space>gs :Gstatus<CR>

  NeoBundleLazy 'tpope/vim-endwise', {
        \ 'autoload' : {
        \   'insert' : 1,
        \ }}
  "ruby, rails
  let s:ruby_filetypes =  [ 'rb', 'rake', 'haml', 'erb', 'pp' ]
  NeoBundleLazy 'vim-ruby/vim-ruby', {
              \   'autoload' : { 'filetypes' : [ 'rb', 'rake', 'haml', 'erb' ] }
              \ }
  NeoBundleLazy 'tpope/vim-rails', {
              \   'autoload' : { 'filetypes' : [ 'rb', 'rake', 'haml', 'erb' ] }
              \ }
  NeoBundleLazy 'ujihisa/unite-rake', {
              \   'autoload' : { 'filetypes' : [ 'rb', 'rake', 'haml', 'erb' ] },
              \   'depends' : 'Shougo/unite.vim'
              \ }
  NeoBundleLazy 'basyura/unite-rails', {
              \   'autoload' : { 'filetypes' : [ 'rb', 'rake', 'haml', 'erb' ] },
              \   'depends' : 'Shougo/unite.vim'
              \ }
  let s:bundle_rails = 'unite-rails unite-rake'
  function! s:bundleLoadDepends(bundle_names)
    execute 'NeoBundleSource '.a:bundle_names
    nnoremap <buffer><C-H><C-H><C-H>  :<C-U>Unite rails/view<CR>
    nnoremap <buffer><C-H><C-H>       :<C-U>Unite rails/model<CR>
    nnoremap <buffer><C-H>            :<C-U>Unite rails/controller<CR>
    nnoremap <buffer><C-H>c           :<C-U>Unite rails/config<CR>
    nnoremap <buffer><C-H>d           :<C-U>Unite rails/db<CR>
    nnoremap <buffer><C-H>l           :<C-U>Unite rails/lib<CR>
    au! RailsLazyPlugins
  endfunction
  aug RailsLazyPlugins
    au User Rails call <SID>bundleLoadDepends(s:bundle_rails)
  aug END

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


  "check plugin and not installed plugin download
  NeoBundleCheck

endif

filetype plugin indent on "required!

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

"Yank
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
  set clipboard& clipboard+=unnamed
endif
"share Mac OS X ClipBoard
vmap <C-c> :w !pbcopy<cr><cr>

"backups
set nobackup
set noswapfile
set nowritebackup

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

"invisible charactor visual setting
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
match JpSpace /　/

"negative screen bell
set t_vb=
set novisualbell

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

"NERDTree auto OPEN
let NERDTreeShowHidden = 1
let file_name = expand("%")
if has('vim_starting') &&  file_name == ""
  autocmd VimEnter * NERDTree ./
endif

"-------------------------
" keybind & mcro
"-------------------------
"escape
imap <C-j> <C-[>

"escape Highlight
nmap <silent> <Esc><Esc> :nohlsearch<CR>

"j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

"selection line by double v
vnoremap v $h

"move window
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

"bracket
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

set nostartofline "Stop certain movements from always going to the first character of a line.
set mouse=a "Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue

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

