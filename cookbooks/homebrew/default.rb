execute 'install homebrew' do
  command 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  not_if 'hash brew 2>/dev/null'
end

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

package "cask"
define :brew_cask do
  name = params[:name]
  unless name
    raise "argument does not exist"
  end

  execute "install #{name}" do
      command "brew cask install #{name}"
      not_if "brew cask list | grep -q #{name}"
  end
end
