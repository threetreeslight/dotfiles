def read_file(name)
  IO.read(File.join(File.expand_path('../', __FILE__), "files/#{name}"))
end

node.reverse_merge!(
  packages: YAML.load(read_file('packages.yaml')),
  apps: YAML.load(read_file('apps.yaml'))
)

# initialize package manager
include_cookbook 'homebrew'

# on-demand cookbook
include_cookbook 'android'
include_cookbook 'bundler'
include_cookbook 'dinghy'
include_cookbook 'git'
include_cookbook 'tmux'
include_cookbook 'vim'
include_cookbook 'xcode'
include_cookbook 'credentials'

include_cookbook 'defaults'
