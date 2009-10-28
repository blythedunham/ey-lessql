


Chef::Log.info("Instance node #{node[:instance_role]}")
Chef::Log.info(node.inspect)

if %w(util).include?(node[:instance_role])
  require_recipe 'mongodb'
end
