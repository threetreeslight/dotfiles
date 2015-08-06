set showmode
set showcmd " Show partial commands in the last line of the screen
set title
set number " Display line numbers on the left
set ruler " Display the cursor position
set laststatus=2 " Always display the status line
set cmdheight=2 " cmd line hiehgt
set visualbell " Use visual bell instead of beeping when doing something wrong
set nowrap " nowrap sentence

" invisible charactor visual setting
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
match JpSpace /　/

" negative screen bell
set t_vb=
set novisualbell

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
