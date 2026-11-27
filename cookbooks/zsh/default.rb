%w( zsh zsh-completions ).each do |n|
  package n
end

%w( .zsh .zshrc ).each do |n|
  dotfile n
end

# prompt (starship is installed via roles/darwin/files/packages.yaml)
dotconfig 'starship.toml'
