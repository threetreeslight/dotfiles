# reattach-to-user-namespace: use tmux to clipbord
%w(
  tmux
  tmux-cssh
  tmuxinator-completion
  reattach-to-user-namespace
).each do |n|
  package n
end

dotfile '.tmux.conf'

# gem_package 'tmuxinator'
dotfile '.tmuxinator'
