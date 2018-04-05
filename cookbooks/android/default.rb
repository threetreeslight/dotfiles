# https://gist.github.com/zeroseis/ce66d4c6b776577442a6#gistcomment-1853098
# drawin only
# execute 'Disable Android File Transfer Agent' do
#   command <<-EOC
# PID=$(ps -fe | grep "[A]ndroid File Transfer Agent" | awk '{print $2}')
# if [[ -n $PID ]]; then
#   kill $PID;
# fi
# 
# cd "/Applications/Android File Transfer.app/Contents/Resources"
# if [[ -f "Android File Transfer Agent.app" ]]; then
#   mv "Android File Transfer Agent.app" "Android File Transfer Agent DISABLED.app";
# fi
# 
# cd "${HOME}/Library/Application Support/Google/Android File Transfer"
# if [[ -f "Android File Transfer Agent.app" ]; then
#   mv "Android File Transfer Agent.app" "Android File Transfer Agent DISABLED.app";
# fi
# EOC
# end
