node[:packages].each do |p|
  package p
end

node[:apps].each do |app|
  brew_cask app
end

# other
%w( .tigrc .gemrc .sshrc ).each do |n|
  dotfile n
end

execute 'restart-shell' do
  command 'exec -l $SHELL'
  action :nothing
end
