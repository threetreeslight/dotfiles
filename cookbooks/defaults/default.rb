node[:packages].each do |p|
  package p
end

brew_tap "devhubapp/devhub"
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

# lltsv_archive = case node[:platform]
#                 when 'darwin'
#                   'lltsv_darwin_amd64'
#                 end
# 
# github_binary "lltsv" do
#   version "v0.6.1"
#   repository "sonots/lltsv"
#   archive lltsv_archive
# end
