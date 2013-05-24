"" plugnin
"
"neobundle
set nocompatible " be iMproved 
"
filetype off     " Required!
if has('vim_starting')
  set runtimepath+=~/.vim/neobundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'

" My Bundles here:
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github

"" recommended by NeoBundle 何のVimpluginか後でチェック
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"" vim-scripts repos
"NeoBundle 'L9'
"NeoBundle 'FuzzyFinder'

"utlity
NeoBundle 'Shougo/unite.vim'
NeoBundle 'sakuraiyuta/commentout.vim' "commentout alias command
NeoBundle 'scrooloose/nerdtree' "directory tree
NeoBundle 'altercation/vim-colors-solarized' "color schema
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'} "for pwoerline

"comple
NeoBundle 'vim-scripts/AutoComplPop'
NeoBundle 'Shougo/neocomplcache' "comple
NeoBundle 'm2ym/rsense' "ruby comple
NeoBundle 'Shougo/neocomplcache-rsense.vim' "rsense for neocomplcache

"compile
NeoBundle 'thinca/vim-quickrun'

"indent syntax
NeoBundle 'nathanaelkane/vim-indent-guides'

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

"" display
"
set showmode
set title
set number "Display line numbers on the left
set ruler "Display the cursor position 
set laststatus=2 "Always display the status line
set visualbell "Use visual bell instead of beeping when doing something wrong
set showcmd "Show partial commands in the last line of the screen
set showmatch
set laststatus=2
set nowrap "nowrap sentence
set hidden "Allows you to switch from an unsaved buffer without saving it first.

" Use ClipBoard
vmap <C-c> :w !pbcopy<cr><cr>

"solarized
syntax enable
set background=dark
colorscheme solarized

"NERDTree auto OPEN
let NERDTreeShowHidden = 1
let file_name = expand("%")
if has('vim_starting') &&  file_name == ""
  autocmd VimEnter * NERDTree ./
endif


"" utlity
"

" unite.vim
" nnoremap [unite]   <Nop>
nmap     <Leader>f [unite]
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

"shortcut
imap <C-j> <C-[>
imap <C-k> <C-m>
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

set nostartofline "Stop certain movements from always going to the first character of a line.
set mouse=a "Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue

"tab, indent
set expandtab
set ts=2 sw=2 sts=0
set smartindent 
set backspace=indent,eol,start "Allow backspacing over autoindent, line breaks and start of insert action
"Indent Syntax
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=darkblue
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=yellow ctermbg=darkcyan
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1


"" autocomp
"
"autocomp
set wildmenu "Better command-line completion

"ruby
let g:ruby_path = ""

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

"js, node auto comp
autocmd FileType javascript,coffee setlocal omnifunc=nodejscomplete#CompleteJS
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
let g:node_usejscomplete = 1


autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif


"" search
"
set nohlsearch "Highlight searche
set noincsearch
set ignorecase "Use case insensitive search, except when using capital letters
set smartcase
set wrapscan
