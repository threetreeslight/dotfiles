execute 'AppleShowAllFiles' do
  not_if 'test $(defaults read com.apple.Finder AppleShowAllFiles) -eq 1'
  command 'defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder'
end
