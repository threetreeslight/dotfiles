# vim

When you want Insert Mode Paste, cancel auto Indent

```
:set paste
:set nopaste
```

History

```
q:
q\
q?
```

Tab

```
tc : create new tab
tx : close current tab
tn : move to next tab
tp : move to previous tab
```

Unite

* `<C-U><C-U>` : file/rec
* `<C-U><C-R>` : file
* `<C-U><C-D>` : dir
* `<C-U><C-F>` : exploer
* `<C-]>`      : ctags jump
* `<C-t>`      : jump history

Filer

- E: edit file with split

git

* `<Space>gd`: git diff
* `<Space>gs`: git status
* `<C-C>`:     git commit
* `<Space>gb`: git blame
* `:Gbrowse` : Open github with target line

complement

* `tab`

sunippet

html

* <http://emmet.io/>

ruby

* `,r` : RuboCop

rails

* `<C-H><C-H>` : show controllers list
* `<C-H><C-V>` : show views list
* `<C-H><C-M>` : show models list
* `<C-H>j` : show javascripts list
* `<C-H>s` : show stylesheets list
* `<C-H>c` : show config list
* `<C-H>d` : show db list
* `<C-H>l` : show lib list

rspec

```
,t : run current spec file
,s : run nearest spec
,l : run last spec
,a : run all spec
```

other usage

* `<C-J>` : escape insert mode
* `<Esc><Esc>` : escape highlight
* `<C-t>` : trim white space
* `:Codic <args>` saerch variable words
* `<C-c>` : yank clipbord (mac osx only)
* `<C-P>` : Yank Ring
* `cs'"` : srround `'` to `"`
* `ds'` : delete srround `'`
* `csw'` : srround `'`
* `:ag` : grep
* `:FixWhitespace` : Trim white space




