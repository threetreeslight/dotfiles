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

  "" Display
  " ----------------------------------------
  "
  " powerlineline
  NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
  " solarizedcolor schema
  NeoBundle 'altercation/vim-colors-solarized'
  " indet syntax {{{
  NeoBundle 'nathanaelkane/vim-indent-guides'
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=darkblue
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=yellow ctermbg=darkcyan
  let g:indent_guides_color_change_percent = 30
  let g:indent_guides_guide_size = 1
  "}}}


  "" Unite
  " ----------------------------------------
  "
  NeoBundleLazy 'Shougo/unite.vim', {
        \ 'autoload' : {
        \   'commands' : [ 'Unite' ]
        \ }}
  let s:bundle = neobundle#get('unite.vim')
  function! s:bundle.hooks.on_source(bundle)
    let g:unite_enable_start_insert=0 "start by insert mode

    "buffer list 
    "TODO: humm...not working
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

  "" filer
  " ----------------------------------------
  "
  " nardtree {{{
  NeoBundle 'scrooloose/nerdtree'
  " NERDTree auto open when vim start with no files
  let NERDTreeShowHidden = 1
  let file_name = expand("%")
  if has('vim_starting') && file_name == ""
    autocmd VimEnter * NERDTree ./
  endif
  "}}}

  " vimfiler{{{
  NeoBundleLazy 'Shougo/vimfiler', {
        \   'autoload' : { 'commands' : [ 'VimFilerBufferDir', 'VimFilerExplorer' ] },
        \   'depends' : [ 'Shougo/unite.vim' ]
        \ }
  let s:bundle = neobundle#get('vimfiler')
  function! s:bundle.hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
  endfunction
  "}}}

  "" utility
  " ----------------------------------------
  "
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'vim-scripts/YankRing.vim'
  NeoBundle 'vim-scripts/surround.vim'
  let s:bundle = neobundle#get('surround.vim')
  function! s:bundle.hooks.on_source(bundle)
    nmap ,( csw(
    nmap ,) csw)
    nmap ,{ csw{
    nmap ,} csw}
    nmap ,[ csw[
    nmap ,] csw]
    nmap ,' csw'
    nmap ," csw"
  endfunction

  NeoBundleLazy 'tpope/vim-endwise', {
        \ 'autoload' : {
        \   'insert' : 1,
        \ }}
 
  "" complement
  " ----------------------------------------
  "
  NeoBundleLazy 'Shougo/neocomplcache', {
        \ 'autoload' : {
        \   'insert' : 1,
        \ } }
  let s:bundle = neobundle#get('neocomplcache')
  function! s:bundle.hooks.on_source(bundle)
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplcache
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase
    let g:neocomplcache_enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
       \ 'default' : '',
       \ 'vimshell' : $HOME.'/.vimshell_hist',
       \ }

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplcache#smart_close_popup() . "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()

    " AutoComplPop like behavior.
    let g:neocomplcache_enable_auto_select = 1

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    " let g:neocomplcache_omni_patterns.javascript = 'nodejscomplete#CompleteJS'
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  endfunction

  "" git
  " ----------------------------------------
  "
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'tpope/vim-fugitive'
  let s:bundle = neobundle#get('vim-fugitive')
  function! s:bundle.hooks.on_source(bundle)
    "vim-fugitive map map
    nnoremap <silent> <Space>gb :Gblame<CR>
    nnoremap <silent> <Space>gd :Gdiff<CR>
    nnoremap <silent> <Space>gs :Gstatus<CR>
  endfunction

  "" syntax
  " ----------------------------------------
  "
  " syntax check
  NeoBundle 'scrooloose/syntastic'
  " xyntax highlight
  NeoBundleLazy 'othree/html5.vim.git', {
      \ 'autoload': {'filetypes': ['html'] }}
  "css
  NeoBundleLazy 'hail2u/vim-css3-syntax', {
      \ 'autoload': {'filetypes': ['css']}}
  NeoBundleLazy 'skammer/vim-css-color', {
      \ 'autoload': {'filetypes': ['css','less','scss.css','sass.css'] }}
  " less
  NeoBundleLazy 'groenewege/vim-less', {
      \ 'autoload': { 'filetypes': 'less'}}
  " scss
  NeoBundleLazy 'cakebaker/scss-syntax.vim', {
      \ 'autoload': { 'filetypes': ['scss.css','sass.css'] }}
  "js,node
  NeoBundleLazy 'pangloss/vim-javascript', {
      \ 'autoload': { 'filetypes': ['javascript']}}
  NeoBundleLazy 'kchmck/vim-coffee-script', {
      \ 'autoload': { 'filetypes': ['coffee']}}



  "" ruby, rails
  " ----------------------------------------
  "
  NeoBundleLazy 'vim-ruby/vim-ruby', {
      \   'autoload' : { 'filetypes' : 'ruby' }
      \ }
  NeoBundleLazy 'tpope/vim-rails', {
      \   'autoload' : { 'filetypes' : 'ruby' }
      \ }
  NeoBundleLazy 'ujihisa/unite-rake', {
      \   'autoload' : { 'filetypes' : 'ruby' },
      \   'depends' : [ 'Shougo/unite.vim' ]
      \ }
  " unite-rails {{{
  NeoBundleLazy 'basyura/unite-rails', {
      \   'autoload' : { 'filetypes' : 'ruby' },
      \   'depends' : ['Shougo/unite.vim']
      \ }
  let s:bundle = neobundle#get('unite-rails')
  function! s:bundle.hooks.on_source(bundle)
    nnoremap <buffer><C-H>   :<C-U>Unite rails/controller<CR>
    nnoremap <buffer><C-H>v  :<C-U>Unite rails/view<CR>
    nnoremap <buffer><C-H>m  :<C-U>Unite rails/model<CR>
    nnoremap <buffer><C-H>j  :<C-U>Unite rails/javascript<CR>
    nnoremap <buffer><C-H>s  :<C-U>Unite rails/stylesheet<CR>
    nnoremap <buffer><C-H>c  :<C-U>Unite rails/config<CR>
    nnoremap <buffer><C-H>d  :<C-U>Unite rails/db<CR>
    nnoremap <buffer><C-H>l  :<C-U>Unite rails/lib<CR>
    au! RailsLazyPlugins
  endfunction
  aug RailsLazyPlugins
    au User Rails call <SID>bundleLoadDepends(s:bundle_rails)
  aug END
  " }}}

  " rspec
  NeoBundleLazy 'alpaca-tc/neorspec.vim', {
        \ 'depends' : 'tpope/vim-rails',
        \ 'autoload' : {
        \   'commands' : [ 'RSpecAll', 'RSpecNearest', 'RSpecRetry', 'RSpecCurrent', 'RSpec' ]
        \ }}
  NeoBundleLazy 'tpope/vim-dispatch', { 'autoload' : {
        \ 'commands' : ['Dispatch', 'FocusDispatch', 'Start']
        \ }}
 
  " NeoBundle 'vim-scripts/dbext.vim'
  " NeoBundle 'digitaltoad/vim-jade'



  "" check plugin and not installed plugin download
  " ----------------------------------------
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

"bracket
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

set nostartofline "Stop certain movements from always going to the first character of a line.
set mouse=a "Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue

"-------------------------
" complement
"-------------------------
set wildmenu "Better command-line completion

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

