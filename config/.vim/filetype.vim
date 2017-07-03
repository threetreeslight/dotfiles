if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  " shell
  au BufRead,BufNewFile *.shell setfiletype shell
  " Scala
  autocmd BufRead,BufNewFile *.scala setfiletype scala
  " Nemerle
  autocmd BufRead,BufNewfile *.n setf nemerle
  " Perl6
  autocmd BufRead,BufNewfile *.p6 setf perl6
  " Perl5
  autocmd BufRead,BufNewfile *.p5 setf perl
  " c,c++,objc
  au BufRead,BufNewFile *.c setfiletype c
  au BufRead,BufNewFile *.cpp setfiletype cpp
  au BufRead,BufNewFile *.m,*.h setfiletype objc
  " php
  au BufRead,BufNewFile *.php,*.phtml,*.ctp setfiletype php
  " python
  au BufRead,BufNewFile *.py setfiletype python
  " ruby
  au BufRead,BufNewFile *.rb,*.erb,*.eruby,*.rspec,*.pp,*.cap,Capfile,Gemfile,Rakefile,Puppetfile,Guradfile,Routefile,Podfile setfiletype ruby
  " javascript
  au BufRead,BufNewFile *.javascript,*.node,*.json,*.typescript,Grantfile setfiletype javascript
  au BufRead,BufNewFile *.coffeescript, *.coffee setfiletype coffee
  " sql
  au BufRead,BufNewFile *.sql setfiletype sql
  " template engine
  au BufRead,BufNewFile *.html setfiletype html
  au BufRead,BufNewFile *.haml setfiletype haml
  au BufRead,BufNewFile *.slim setfiletype slim
  " TeXEruby
  autocmd BufRead,BufNewFile *.tex.erb setfiletype tex.eruby
  "css
  au BufRead,BufNewFile *.css setfiletype css
  au BufRead,BufNewFile *.less setfiletype less
  au BufRead,BufNewFile *.sass setfiletype scss
  " Filetype detect for Assembly Language.
  autocmd BufRead,BufNewFile *.asm set ft=masm syntax=masm
  autocmd BufRead,BufNewFile *.inc set ft=masm syntax=masm
  autocmd BufRead,BufNewFile *.[sS] set ft=gas syntax=gas
  autocmd BufRead,BufNewFile *.hla set ft=hla syntax=hla
  " Filetype detect for setting
  au BufRead,BufNewFile *.ini.* setfiletype dosini
  " Markdown
  autocmd BufRead,BufNewFile *.mkd,*.markdown,*.md,*.mdown,*.mkdn
        \ setlocal filetype=mkd autoindent formatoptions=tcroqn2 comments=n:>
augroup END
