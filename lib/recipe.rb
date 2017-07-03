include_recipe 'recipe_helper'
include_recipe 'cookbook_helper'

# update node information
node.reverse_merge!(
  os: run_command('uname').stdout.strip.downcase,
)

node.reverse_merge!(
  user: ENV['USER'],
)

include_role node[:platform]
