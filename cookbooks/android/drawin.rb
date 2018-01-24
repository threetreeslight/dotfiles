# https://gist.github.com/zeroseis/ce66d4c6b776577442a6#gistcomment-1853098
execute 'Disable Android File Transfer Agent' do
  not_if "test -F #{git_config_ignore_path} && echo true"
  command <<-EOC
PID=$(ps -fe | grep "[A]ndroid File Transfer Agent" | awk '{print $2}')
if [[ -n $PID ]]; then
  kill $PID;
fi

cd /Applications/Android File Transfer.app/Contents/Resources
mv "Android File Transfer Agent.app" "Android File Transfer Agent DISABLED.app"

cd "${HOME}/Library/Application Support/Google/Android File Transfer"
mv "Android File Transfer Agent.app" "Android File Transfer Agent DISABLED.app"
EOC
end
