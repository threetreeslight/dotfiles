augroup filetypedetect
  au BufRead,BufNewFile *.ini.* setfiletype dosini
  au BufRead,BufNewFile *.c setfiletype c
  au BufRead,BufNewFile *.cpp setfiletype cpp
  au BufRead,BufNewFile *.m,*.h setfiletype objc
  au BufRead,BufNewFile *.css setfiletype css
  au BufRead,BufNewFile *.less setfiletype less
  au BufRead,BufNewFile *.sass setfiletype scss
  au BufRead,BufNewFile *.scss setfiletype sass
  au BufRead,BufNewFile *.html setfiletype html
  au BufRead,BufNewFile *.javascript,*.node,*.json,*.typescript,Grantfile setfiletype javascript
  au BufRead,BufNewFile *.coffeescript, *.coffee setfiletype coffee
  au BufRead,BufNewFile *.php,*.phtml,*.ctp setfiletype php
  au BufRead,BufNewFile *.py setfiletype python
  au BufRead,BufNewFile *.rb,*.erb,*.eruby,*.rspec,*.pp,*.cap,Capfile,Gemfile,Rakefile,Puppetfile,Guradfile,Routefile,Podfile setfiletype ruby
  au BufRead,BufNewFile *.haml setfiletype haml
  au BufRead,BufNewFile *.slim setfiletype slim
  au BufRead,BufNewFile *.scala setfiletype scala
  au BufRead,BufNewFile *.shell setfiletype shell
  au BufRead,BufNewFile *.sql setfiletype sql
  au BufRead,BufNewFile *.md setfiletype markdown
augroup END
