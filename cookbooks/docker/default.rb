%w(
  docker
  docker-compose
  docker-credential-helper
  docker-machine
).each do |pkg|
  package pkg
end

%w(
  kubernetes-helm
  stern
  shyiko/kubesec/kubesec
).each do |pkg|
  package pkg
end

# Put library for symlink to $HOME/bin
directory "$HOME/lib"
# $HOME/bin included $PATH
directory "$HOME/bin"

execute 'Install Istio' do
  not_if 'test -L ${HOME}/bin/istioctl'
  command <<-EOC
cd /tmp
curl -L https://git.io/getLatestIstio | sh -

mv ./istio-1.0.2 ~/lib
cd ~/bin
ln -s ../lib/istio-1.0.2/bin/istioctl bin/istioctl
EOC
end


