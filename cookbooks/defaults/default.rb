execute 'install homebrew' do
  command 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  not_if 'hash brew 2>/dev/null'
end

execute 'brew update and cleanup' do
  command 'brew update && brew cleanup'
  only_if 'hash brew 2>/dev/null'
end

node[:packages].each do |p|
  package p
end

node[:apps].each do |app|
  execute "install #{app}" do
    command "brew cask install #{app}"
    not_if "brew cask list | grep -q #{app}"
  end
end

# TODO install ruby

execute 'install ghq' do
  command 'go get github.com/motemen/ghq'
  not_if 'test -d $HOME/src/github.com/motemen'
  # notifies :run, 'execute[restart-shell]'
end

# https://github.com/creationix/nvm
execute 'install nvm' do
  command 'curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash'
  not_if 'test -s ~/.nvm'
  # notifies :run, 'execute[restart-shell]'
end
# TODO install node

execute 'install google-cloud-sdk' do
  command 'curl https://sdk.cloud.google.com | bash'
  not_if 'test -d $HOME/google-cloud-sdk'
  # notifies :run, 'execute[restart-shell]'
end

# TODO: execute symlink dotfiles
# TODO: execute symlink confidential files from dropbox

execute 'symlink config' do
  command <<-CMD
#
# symlink dot files and directories
#
DOT_FILES=(vimrc tmux.conf zshrc zshenv gitconfig gitignore_global gitattributes tigrc gemrc sshrc)
DOT_DIRECTORIES=(vim bundle git_template dinghy)

REQUIRE_RESTART=0

for file in ${DOT_FILES[@]}
do
  if [ -e $HOME/.$file ]; then
    echo "[WARN] $file file is existed."
  else
    ln -s $HOME/dotfiles/$file $HOME/.$file
    echo "[INFO] $file symlinked."
    REQUIRE_RESTART=1
  fi
done

for directory in ${DOT_DIRECTORIES[@]}
do
  if [ -d $HOME/.$directory ]; then
    echo "[WARN] .$directory directory is existed."
  else
    ln -s $HOME/dotfiles/$directory $HOME/.$directory
    REQUIRE_RESTART=1
    echo "[INFO] $directory symlinked."
  fi
done

#
# symlink diff-highlight
#
if [ -L /usr/local/bin/diff-highlight ]; then
  echo "[WARN] Symlinked diff-highlight"
else
  find /opt/boxen -name diff-highlight | awk 'NR == 2 {print "sudo ln -s",$0,"/usr/local/bin/"}'
  REQUIRE_RESTART=1
  echo "[INFO] diff-highlight symlinked."
fi

#
# xcode
#
XCODE_HOME=${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes
if [ -L ${XCODE_HOME}/Solarized\ -\ Ae06710.dvtcolortheme ]; then
  echo "[WARN] Exist xcode themes"
else
  echo "[INFO] Copy xcode themes"
  mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
  ln -s ${HOME}/dotfiles/themes/apple-xcode4-solarized/Solarized\ -\ Ae06710.dvtcolortheme ${XCODE_HOME}
  REQUIRE_RESTART=1
fi

if [ $REQUIRE_RESTART -eq 1 ]; then
  exec -l $SHELL
fi
CMD
  action :nothing
end

# execute 'restart-shell' do
#   command 'exec -l $SHELL'
#   action :nothing
# end
