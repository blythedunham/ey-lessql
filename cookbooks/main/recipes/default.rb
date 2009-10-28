
execute "My ROLE IS: #{node[:instance_role]}" do
   Chef::Log.info("Instance node #{node[:instance_role]}")
   Chef::Log.info(node.inspect.to_s)
end

#require_recipe 'tokyo'

if %w(util).include?(node[:instance_role])
  require_recipe 'mongodb'
end
