# ghq: managed by Homebrew and upgraded to the latest release on every run
package 'ghq'

execute 'upgrade ghq' do
  command 'brew upgrade ghq'
  only_if 'brew outdated --quiet | grep -qx ghq'
end

# remove binaries left by the former `go install` setup; they shadow brew's ghq in PATH
%W(#{ENV['HOME']}/bin/ghq #{ENV['HOME']}/go/bin/ghq).each do |path|
  file path do
    action :delete
  end
end
