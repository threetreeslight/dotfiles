execute 'symlink config' do
  command <<-CMD
XCODE_HOME=${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes
if [ -L ${XCODE_HOME}/Solarized\ -\ Ae06710.dvtcolortheme ]; then
  echo "[WARN] Exist xcode themes"
else
  echo "[INFO] Copy xcode themes"
  mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
  ln -s ${HOME}/dotfiles/themes/apple-xcode4-solarized/Solarized\ -\ Ae06710.dvtcolortheme ${XCODE_HOME}
  REQUIRE_RESTART=1
fi
CMD
  action :nothing
end
