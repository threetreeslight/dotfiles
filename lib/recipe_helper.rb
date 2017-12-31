# Some implementation refered from k0kubun/dotfiles
# https://github.com/k0kubun/dotfiles/blob/master/lib/recipe_helper.rb
# Authored by k0kubun

MItamae::RecipeContext.class_eval do
  def include_cookbook(name)
    root_dir = File.expand_path('../..', __FILE__)
    include_recipe File.join(root_dir, 'cookbooks', name, 'default')
  end

  def include_role(name)
    root_dir = File.expand_path('../..', __FILE__)
    include_recipe File.join(root_dir, 'roles', name, 'default')
  end

  def has_package?(name)
    result = run_command("dpkg-query -f '${Status}' -W #{name.shellescape} | grep -E '^(install|hold) ok installed$'", error: false)
    result.exit_status == 0
  end
end
