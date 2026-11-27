"-------------------------
" オートコマンド設定
"-------------------------

" 前回のカーソル位置を復元
" autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 全角スペースをハイライト
function! s:full_width_space_highlight() abort
  highlight FullWidthSpace cterm=underline ctermbg=darkgray gui=underline guibg=#5f5f5f
endfunction

augroup full_width_space
  autocmd!
  autocmd ColorScheme * call s:full_width_space_highlight()
  autocmd VimEnter,WinNew * if !exists('w:full_width_space')
        \ | let w:full_width_space = matchadd('FullWidthSpace', '\%u3000')
        \ | endif
augroup END
call s:full_width_space_highlight()
