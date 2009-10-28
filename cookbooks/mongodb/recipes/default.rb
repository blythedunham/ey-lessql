#
# Cookbook Name:: mongodb
# Recipe:: default


directory "/data/master" do
  owner node[:owner_name]
  group node[:owner_name]
  mode 0755
  recursive true
end

directory "/data/slave" do
  owner node[:owner_name]
  group node[:owner_name]
  mode 0755
  recursive true
end

node[:applications].each do |app_name, data|

  template "/data/#{app_name}/shared/config/keep.database.yml" do
    source "mongodb.yml.erb"
    owner user[:username]
    group user[:username]
    mode 0744
    variables({
      :host => node[:ec2][:public_hostname],
      :port => '',
    })
  end
end

execute "install-mongodb" do
  command %Q{
    curl -O http://downloads.mongodb.org/linux/mongodb-linux-i686-1.0.1.tgz &&
    tar zxvf mongodb-linux-i686-1.0.1.tgz &&
    mv mongodb-linux-i686-1.0.1 /usr/local/mongodb &&
    rm mongodb-linux-i686-1.0.1.tgz
  }
  not_if { File.directory?('/usr/local/mongodb') }
end

#execute "install-mongodb-64" do

#  command %Q{
#    curl -O http://downloads.mongodb.org/linux/mongodb-linux-x86_64-1.0.0.tgz &&
#    tar zxvf mongodb-linux-x86_64-1.0.0.tgz &&
#    mv mongodb-linux-x86_64-1.0.0 /usr/local/mongodb &&
#    rm mongodb-linux-x86_64-1.0.0.tgz
#  }
#  not_if { File.directory?('/usr/local/mongodb') }
#end
  
execute "add-to-path" do
  command %Q{
    echo 'export PATH=$PATH:/usr/local/mongodb/bin' >> /etc/profile
  }
  not_if "grep 'export PATH=$PATH:/usr/local/mongodb/bin' /etc/profile"
end
  
#execute "install-mongomapper" do
#  command %Q{
#    gem install jnunemaker-mongomapper --source http://gems.github.com
#  }
#end

remote_file "/etc/init.d/mongodb" do
  source "mongodb"
  owner "root"
  group "root"
  mode 0755
end

execute "add-mongodb-to-default-run-level" do
  command %Q{
    rc-update add mongodb default
  }
  not_if "rc-status | grep mongodb"
end

execute "ensure-mongodb-is-running" do
  command %Q{
    /etc/init.d/mongodb start
  }
  not_if "pgrep mongod"
end



