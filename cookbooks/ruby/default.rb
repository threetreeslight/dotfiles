%w(ruby-build rbenv).each do |pkg|
  package pkg
end

ruby_version = '2.5.3'
execute "Install ruby #{ruby_version}" do
  command <<-EOC
    rbenv install #{ruby_version}
    rbenv global #{ruby_version}
    rbenv rehash
  EOC
  not_if "rbenv version | grep -p #{ruby_version} 2>/dev/null"
end

# install mruby
%w(mruby mruby-cli).each do |pkg|
  package pkg
end
