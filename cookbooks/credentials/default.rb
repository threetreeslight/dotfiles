define :dotfile_credential, source: nil, target: nil do
  source = params[:source] || params[:name]
  link File.join(ENV['HOME'], params[:name]) do
    to File.join(ENV['HOME'], "/Dropbox/dev/dotfiles/#{source}")
    user node[:user]
  end
end

dotfile_credential '.gitconfig.local'
dotfile_credential '.papertrail.yml'
