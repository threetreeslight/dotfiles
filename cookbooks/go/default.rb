package 'go'

execute 'ghq' do
  not_if 'command -v ghq > /dev/null'
  command 'go install github.com/x-motemen/ghq@latest'
end
