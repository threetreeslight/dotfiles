%w( zsh zsh-completions ).each do |n|
  package n
end

%w( .zsh .zshrc ).each do |n|
  dotfile n
end
