require 'win32/service'
require 'win32/service'

ENV['PATH'] += ";#{node['smm_mysql']['windows']['bin_dir']}"
package_file = Chef::Config[:file_cache_path] + node['smm_mysql']['windows']['package_file']
install_dir = win_friendly_path(node['smm_mysql']['windows']['basedir'])

def package(*args, &blk)
  windows_package(*args, &blk)
end

#----
windows_path node['smm_mysql']['windows']['bin_dir'] do
  action :add
end

remote_file package_file do
  source node['smm_mysql']['windows']['url']
  not_if { ::File.exists?(package_file) }
end

windows_package node['smm_mysql']['windows']['packages'].first do
  source package_file
  options "INSTALLDIR=\"#{install_dir}\""
  notifies :run, resources('execute[install mysql service]'), :immediately
end

#--- FIX ME - directories

#----
execute 'install mysql service' do
  command %Q["#{node['smm_mysql']['windows']['bin_dir']}\\mysqld.exe" --install "#{node['smm_mysql']['server']['service_name']}"]
  not_if { ::Win32::Service.exists?(node['smm_mysql']['windows']['service_name']) }
end

#----
template 'initial-my.cnf' do
  path "#{node['smm_mysql']['windows']['conf_dir']}/my.cnf"
  source 'my.cnf.erb'
  mode '0644'
  notifies :reload, node['smm_mysql']['windows']['service_name'], :delayed
end

#----

windows_path node['smm_mysql']['bin_dir'] do
  action :add
end

windows_batch 'install mysql service' do
  command "\"#{node['smm_mysql']['bin_dir']}\\mysqld.exe\" --install #{node['smm_mysql']['service_name']}"
  not_if  { Win32::Service.exists?(node['smm_mysql']['service_name']) }
end

#----

src_dir = win_friendly_path("#{node['smm_mysql']['basedir']}\\data")
target_dir = win_friendly_path(node['smm_mysql']['data_dir'])

%w{mysql performance_schema}.each do |db|
  execute 'mysql-move-db' do
    command %Q[move "#{src_dir}\\#{db}" "#{target_dir}"]
    action :run
    not_if { File.exists?(node['smm_mysql']['data_dir'] + '/mysql/user.frm') }
  end
end

#----

execute 'mysql-install-db' do
  command 'mysql_install_db'
  action :run
  not_if { File.exists?(node['smm_mysql']['data_dir'] + '/mysql/user.frm') }
end

service 'mysql' do
  service_name node['smm_mysql']['service_name']
  provider     Chef::Provider::Service::Upstart if node['smm_mysql']['use_upstart']
  supports     :status => true, :restart => true, :reload => true
  action       :enable
end

template 'final-my.cnf' do
  path "#{node['smm_mysql']['conf_dir']}/my.cnf"
  source 'my.cnf.erb'
  mode '0644'
  notifies :restart, resources('service[mysql]'), :immediately
end

#----

execute 'assign-root-password' do
  command %Q["#{node['smm_mysql']['mysqladmin_bin']}" -u root password '#{node['smm_mysql']['server_root_password']}']
  action :run
  only_if %Q["#{node['smm_mysql']['mysql_bin']}" -u root -e 'show databases;']
end

#----

grants_path = node['smm_mysql']['grants_path']

begin
  resources("template[#{grants_path}]")
rescue
  Chef::Log.info('Could not find previously defined grants.sql resource')
  template grants_path do
    source 'grants.sql.erb'
    mode   '0600'
    action :create
  end
end

#----
windows_batch 'mysql-install-privileges' do
  command "\"#{node['smm_mysql']['mysql_bin']}\" -u root #{node['smm_mysql']['server_root_password'].empty? ? '' : '-p' }\"#{node['smm_mysql']['server_root_password']}\" < \"#{grants_path}\""
  action :nothing
  subscribes :run, resources("template[#{grants_path}]"), :immediately
end

service 'mysql-start' do
  service_name node['smm_mysql']['server']['service_name']
  action :start
end
