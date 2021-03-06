# Some implementation refered from k0kubun/dotfiles
# https://github.com/k0kubun/dotfiles/blob/master/cookbooks/functions/default.rb
# Authored by k0kubun

define :dotfile, source: nil do
  source = params[:source] || params[:name]
  link File.join(ENV['HOME'], params[:name]) do
    to File.expand_path("../../config/#{source}", __FILE__)
    user node[:user]
  end
end

define :dotconfig, source: nil do
  source = params[:source] || params[:name]

  dotconfig_path = "#{ENV['HOME']}/.config"
  directory dotconfig_path

  link File.join(dotconfig_path, params[:name]) do
    to File.expand_path("files/.config/#{source}", __FILE__)
    user node[:user]
  end
end

# it depend on cookbook/go/default.rb
define :ghq do
  repo = params[:name]

  execute "ghq get #{repo}" do
    not_if "test -d #{ENV['HOME']}/src/github.com/#{repo}"
  end
end

define :github_binary, version: nil, repository: nil, archive: nil, binary_path: nil do
  cmd = params[:name]
  bin_path = "#{ENV['HOME']}/bin/#{cmd}"
  archive = params[:archive]
  url = "https://github.com/#{params[:repository]}/releases/download/#{params[:version]}/#{archive}"

  if archive.end_with?('.zip')
    extract = "unzip -o"
    has_ext = true
  elsif archive.end_with?('.tar.gz')
    extract = "tar xvzf"
    has_ext = true
  else
    has_ext = false
  end

  execute "curl -fSL -o /tmp/#{archive} #{url}" do
    not_if "test -f #{bin_path}"
  end

  if has_ext
    execute "#{extract} /tmp/#{archive}" do
      not_if "test -f #{bin_path}"
      cwd "/tmp"
    end
  else
    execute "mv /tmp/#{archive} /tmp/#{cmd}" do
      not_if "test -f #{bin_path}"
      cwd "/tmp"
    end
  end

  execute "mv /tmp/#{params[:binary_path] || cmd} #{bin_path} && chmod +x #{bin_path}" do
    not_if "test -f #{bin_path}"
  end
end
