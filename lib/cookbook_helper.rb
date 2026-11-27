# Some implementation refered from k0kubun/dotfiles
# https://github.com/k0kubun/dotfiles/blob/master/cookbooks/functions/default.rb
# Authored by k0kubun

define :dotfile, source: nil do
  source = params[:source] || params[:name]
  link File.join(ENV['HOME'], params[:name]) do
    to File.expand_path("../../config/#{source}", __FILE__)
    user node[:user]
    force true
  end
end

define :dotconfig, source: nil do
  source = params[:source] || params[:name]

  dotconfig_path = "#{ENV['HOME']}/.config"
  directory dotconfig_path

  link File.join(dotconfig_path, params[:name]) do
    to File.expand_path("../../config/.config/#{source}", __FILE__)
    user node[:user]
    force true
  end
end

# it depends on cookbooks/ghq/default.rb
define :ghq do
  repo = params[:name]

  execute "ghq get #{repo}" do
    not_if "test -d #{ENV['HOME']}/src/github.com/#{repo}"
    command "ghq get #{repo}"
  end
end
