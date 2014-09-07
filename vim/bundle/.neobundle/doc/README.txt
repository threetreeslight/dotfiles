First, copy this file to ~/.vim/syntax/ini.vim. (You will need to create that directory, if you haven't already.)

Then, to make vim automatically use that syntax definition for .ini and hgrc files, you'll need to add this to your ~/.vim/filetype.vim file (which you will need to create, if you haven't already):

au BufNewFile,BufRead *.ini,*/.hgrc,*/.hg/hgrc setf ini

What this means is:
	Upon creating or reading any file
		whose name ends in .ini,
		or whose name is .hgrc,
		or whose name is hgrc and is in a .hg directory,
	set the file type to "ini".

When you set (or the auto-command sets) the file type, vim will load the syntax definition.

This syntax definition and this README are both copyright 2008 Peter Hosey.
