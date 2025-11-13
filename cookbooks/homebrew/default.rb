# execute 'install homebrew' do
#   command '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'
#   not_if 'hash brew 4>/dev/null'
# end

define :brew_tap do
  name = params[:name]
  unless name
    raise "argument does not exist"
  end

  cmd = "brew tap #{name}"
  execute cmd do
    command cmd
    not_if "brew tap-info #{name} 2>/dev/null"
  end
end

execute 'brew update and cleanup' do
  command 'brew update && brew cleanup'
  only_if 'hash brew 2>/dev/null'
end

define :brew_cask do
  name = params[:name]
  unless name
    raise "argument does not exist"
  end

  execute "install #{name}" do
      command "brew install --cask #{name}"
      not_if "brew list --cask | grep -q #{name}"
  end
end
