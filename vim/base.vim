" open buffer alternative new one
set switchbuf=useopen

" alternative close. Use undo history
set hidden

" Stop certain movements from always going to the first character of a line.
set nostartofline
" Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue
set mouse=a

" backups
set nobackup
set noswapfile
set nowritebackup

" Editor -------------------------------------------
" backspace can delete any item
set backspace=indent,eol,start

" Hilight matching (), {} etc...
set showmatch
" Add matchtipes <>
set matchpairs& matchpairs+=<:>

" Indent width is shiftwidth
set shiftround
