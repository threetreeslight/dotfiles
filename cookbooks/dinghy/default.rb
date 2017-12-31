# https://github.com/codekitchen/dinghy

brew_tap 'codekitchen/dinghy'
package 'dinghy'

directory "#{ENV['HOME']}/.dinghy"
dotfile '.dinghy/preferences.yml'
