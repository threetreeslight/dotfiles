"-------------------------
" キーマッピング設定
"-------------------------

" 検索ハイライトの解除
nmap <silent> <Esc><Esc> :nohlsearch<CR>

"-------------------------
" カーソル移動
"-------------------------
" 表示行単位で移動
noremap j gj
noremap k gk

" 選択行をダブルクリックで選択
vnoremap v $h

"-------------------------
" 挿入モード
"-------------------------
" 括弧の自動補完
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

"-------------------------
" 検索
"-------------------------
" /, ? のエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"-------------------------
" タブ操作
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
set showtabline=2 " always show tab line

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
