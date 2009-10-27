execute "testing" do
  command %Q{
    echo "i ran at #{Time.now}" >> /root/cheftime
  }
end

#require_recipe 'tokyo'

if node[:instance_role] == 'db_master'
 require_recipe 'mongodb'
end
