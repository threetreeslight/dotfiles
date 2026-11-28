package 'git'
package 'git-lfs'
package 'git-secrets' # detect secret file on git hook

%w( .gitconfig .git_template ).each do |n|
  dotfile n
end

# Generate Globa ignore setting
# https://git-scm.com/docs/gitignore
# - clone github's ignore repo
# - concat global setting and redirect it to config
#
github_gitignore_dir = "#{ENV['HOME']}/src/github.com/github/gitignore"
directory github_gitignore_dir
git github_gitignore_dir do
  repository 'https://github.com/github/gitignore.git'
end

git_config_dir = "#{ENV['HOME']}/.config/git"
git_config_ignore_path = "#{git_config_dir}/ignore"
directory git_config_dir

# except ignore which included `bin` OR `scripts` dir
ignore_files = Dir.glob(File.join(github_gitignore_dir, "Global/*.gitignore")).select do |f|
  !/(Eclipse|FlexBuilder|Images|Lazarus|ModelSim|SBT|VirtualEnv)/.match(f)
end

# secret / credential patterns that github's Global/* does not cover
secrets_ignore_path = File.expand_path('../files/ignore.secrets', __FILE__)

execute 'Generate global ignore setting' do
  command <<-EOF
    cat #{ignore_files.join(" ")} #{secrets_ignore_path} > #{git_config_ignore_path}
  EOF
end
