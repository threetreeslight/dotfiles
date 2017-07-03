node[:packages].each do |p|
  package p
end

node[:apps].each do |app|
  execute "install #{app}" do
    command "brew cask install #{app}"
    not_if "brew cask list | grep -q #{app}"
  end
end

# other
%w( .tigrc .gemrc .sshrc ).each do |n|
  dotfile n
end

execute 'restart-shell' do
  command 'exec -l $SHELL'
  action :nothing
end
