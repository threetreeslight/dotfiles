# dotnet need to use Q#
brew_cask "dotnet-sdk"
link "/usr/local/bin/dotnet"  do
  to "/usr/local/share/dotnet/dotnet"
  user node[:user]
end
