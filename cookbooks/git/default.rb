package 'git'
package 'git-lfs'
package 'git-secrets' # detect secret file on git hook
package 'git-now'
package 'hub' # github cli

%w( .gitconfig .gitignore_global .gitattributes .git_template ).each do |n|
  dotfile n
end

execute 'symlink diff-highlight' do
  not_if 'test -L /usr/local/bin/diff-highlight && echo true'
  command <<-CMD
  find `brew --prefix` -name diff-highlight | awk 'NR == 2 { print $0 }' | xargs -I{} sudo ln -s {} /usr/local/bin/
CMD
end


