package 'go'

execute 'ghq' do
  not_if 'test -d $HOME/src/github.com/motemen/ghq'
  command 'go get github.com/motemen/ghq'
end
