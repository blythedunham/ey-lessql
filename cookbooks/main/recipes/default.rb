execute "testing" do
  command %Q{
    echo "i ran at #{Time.now}" >> /root/cheftime
  }
end


execute "My ROLE IS: #{node[:instance_rode]}"
  command %Q{ echo "My role is #{node[:instance_rode]}" }
#require_recipe 'tokyo'

if %w(util).include?(node[:instance_role])
  require_recipe 'mongodb'
end
