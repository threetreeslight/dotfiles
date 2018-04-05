if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  " Filetype detect for Assembly Language.
  autocmd BufRead,BufNewFile *.asm set ft=masm syntax=masm
  autocmd BufRead,BufNewFile *.inc set ft=masm syntax=masm
  autocmd BufRead,BufNewFile *.[sS] set ft=gas syntax=gas
  autocmd BufRead,BufNewFile *.hla set ft=hla syntax=hla
  autocmd BufRead,BufNewfile *.n set nemerle
  " c,c++,objc
  au BufRead,BufNewFile *.c setfiletype c 
  au BufRead,BufNewFile *.cpp setfiletype cpp
  au BufRead,BufNewFile *.m,*.h setfiletype objc
  "css
  au BufRead,BufNewFile *.css setfiletype css
  au BufRead,BufNewFile *.less setfiletype less
  au BufRead,BufNewFile *.sass setfiletype scss
  " Filetype detect for setting
  au BufRead,BufNewFile *.ini.* setfiletype dosini
  " javascript
  au BufRead,BufNewFile *.javascript,*.node,*.json,*.typescript,Grantfile setfiletype javascript
  au BufRead,BufNewFile *.coffeescript, *.coffee setfiletype coffee
  autocmd BufRead,BufNewFile *.mkd,*.markdown,*.md,*.mdown,*.mkdn
        \ setlocal filetype=mkd autoindent formatoptions=tcroqn2 comments=n:>
  " perl
  autocmd BufRead,BufNewfile *.p6 setf perl6
  autocmd BufRead,BufNewfile *.p5 setf perl
  " php
  au BufRead,BufNewFile *.php,*.phtml,*.ctp setfiletype php
  " python
  au BufRead,BufNewFile *.py setfiletype python
  " ruby
  au BufRead,BufNewFile *.rb,*.erb,*.eruby,*.rspec,*.pp,*.cap,Capfile,Gemfile,Rakefile,Puppetfile,Guradfile,Routefile,Podfile setfiletype ruby
  " sql
  autocmd BufRead,BufNewFile *.scala setfiletype scala
  au BufRead,BufNewFile *.shell setfiletype shell
  au BufRead,BufNewFile *.sql setfiletype sql
  " template engine
  au BufRead,BufNewFile *.html setfiletype html
  au BufRead,BufNewFile *.haml setfiletype haml
  au BufRead,BufNewFile *.slim setfiletype slim
  " TeXEruby
  autocmd BufRead,BufNewFile *.tex.erb setfiletype tex.eruby
augroup END
