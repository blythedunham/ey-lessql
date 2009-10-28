
execute "My ROLE IS: #{node[:instance_node]}" do
   Chef::Log.info("Instance node #{node[:instance_node]}")
   Chef::Log.info(node.inspect)
end

#require_recipe 'tokyo'

if %w(util).include?(node[:instance_role])
  require_recipe 'mongodb'
end
