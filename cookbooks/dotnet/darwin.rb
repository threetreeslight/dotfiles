# dotnet need to use Q#
%w( dotnet-sdk ).each do |app|
  execute "install #{app}" do
    command "brew cask install #{app}"
    not_if "brew cask list | grep -q #{app}"
  end
end

link "/usr/local/bin/dotnet"  do
  to "/usr/local/share/dotnet/dotnet"
  user node[:user]
end
