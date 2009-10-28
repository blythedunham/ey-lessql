execute "testing" do
  command %Q{
    echo "i ran at #{Time.now}" >> /root/cheftime
  }
end

#require_recipe 'tokyo'

if %w(solo db_master).include?(node[:instance_role])
  require_recipe 'mongodb'
end
