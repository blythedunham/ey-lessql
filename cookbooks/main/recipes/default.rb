
execute "My ROLE IS: #{node[:instance_rode]}" do
  command %Q{
    echo "i ran at #{Time.now} at #{node[:instance_rode]}"
  }
end

#require_recipe 'tokyo'

if %w(util).include?(node[:instance_role])
  require_recipe 'mongodb'
end
