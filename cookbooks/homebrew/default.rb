execute 'install homebrew' do
  command 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  not_if 'hash brew 2>/dev/null'
end

# execute 'brew update and cleanup' do
#   command 'brew update && brew cleanup'
#   only_if 'hash brew 2>/dev/null'
# end
