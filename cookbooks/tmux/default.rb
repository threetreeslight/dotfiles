# reattach-to-user-namespace: use tmux to clipbord
%w( tmux tmux-cssh reattach-to-user-namespace ).each do |n|
  package n
end

dotfile '.tmux.conf'
dotfile '.tmuxinator'
