directory "$HOME/.ssh" do
  user node[:user]
  mode '0700'
end

execute 'create ssh config if missing' do
  command %q(touch "$HOME/.ssh/config")
  not_if %q(test -f "$HOME/.ssh/config")
end

execute 'set ssh config permission' do
  command %q(chmod 600 "$HOME/.ssh/config")
end

# Use 1password registered ssh key
execute 'append identity agent to ssh config' do
  command <<-'EOS'
cat <<'CONF' >> "$HOME/.ssh/config"

Host *
  IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
CONF
EOS
  not_if %q(grep -Fx 'IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"' "$HOME/.ssh/config" 2>/dev/null)
end

