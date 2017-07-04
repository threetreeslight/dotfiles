package 'git'
package 'git-lfs'
package 'git-secrets' # detect secret file on git hook
package 'git-now'
package 'hub' # github cli

%w( .gitconfig .gitignore_global .gitattributes .git_template ).each do |n|
  dotfile n
end

execute 'symlink diff-highlight' do
  command <<-CMD
if [ -L /usr/local/bin/diff-highlight ]; then
  echo "[WARN] Symlinked diff-highlight"
else
  find /opt/boxen -name diff-highlight | awk 'NR == 2 {print "sudo ln -s",$0,"/usr/local/bin/"}'
  REQUIRE_RESTART=1
  echo "[INFO] diff-highlight symlinked."
fi
CMD
end


