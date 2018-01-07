package 'git'
package 'git-lfs'
package 'git-secrets' # detect secret file on git hook
package 'git-now'
package 'hub' # github cli

%w( .gitconfig .gitattributes .git_template ).each do |n|
  dotfile n
end

# ignore global
github_gitignore_dir = "#{ENV['HOME']}/src/github.com/github/gitignore"
directory github_gitignore_dir

git github_gitignore_dir do
  repository 'https://github.com/github/gitignore.git'
end

git_config_dir = "#{ENV['HOME']}/.config/git"
git_config_ignore_path = "#{git_config_dir}/ignore"
directory git_config_dir

execute 'symlink $HOME/.config/git/ignore dir' do
  not_if "test -L #{git_config_ignore_path} && echo true"
  command "ln -s #{github_gitignore_dir}/Global #{git_config_ignore_path}"
end

# diff highlight
# https://github.com/git/git/tree/master/contrib/diff-highlight
execute 'symlink diff-highlight' do
  not_if 'test -L /usr/local/bin/diff-highlight && echo true'
  command <<-CMD
  find `brew --prefix` -name diff-highlight | awk 'NR == 2 { print $0 }' | xargs -I{} sudo ln -s {} /usr/local/bin/
CMD
end
