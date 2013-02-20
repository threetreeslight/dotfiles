"" plugnin
"
"vundle
set nocompatible " be iMproved 
filetype off  " required!
set rtp+=~/.vim/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

"utlity
Bundle 'sakuraiyuta/commentout.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
"solarized
syntax enable
set background=dark
colorscheme solarized

"comple
Bundle 'vim-scripts/AutoComplPop'
Bundle 'Shougo/neocomplcache'

"compile
Bundle 'thinca/vim-quickrun'

"ruby, rails
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/dbext.vim'
Bundle 'digitaltoad/vim-jade'

"" syntax
Bundle 'othree/html5.vim.git'
"css
Bundle 'hail2u/vim-css3-syntax'

Bundle 'skammer/vim-css-color.git'
"less
Bundle 'groenewege/vim-less'

"scss
Bundle 'cakebaker/scss-syntax.vim'

"js, node
Bundle 'teramako/jscomplete-vim'
Bundle 'myhere/vim-nodejs-complete'
Bundle 'kchmck/vim-coffee-script' 

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
set nowrap
set hidden "Allows you to switch from an unsaved buffer without saving it first.

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


"" autocomp
"
"autocomp
set wildmenu "Better command-line completion

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
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
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
