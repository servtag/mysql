service 'monit' do
  supports :status => false, :restart => true, :reload => true
  action :nothing
end

template '/etc/monit/conf.d/mysql.monitrc' do
  source 'mysql.monitrc.erb'
  mode 0644
  notifies :restart, 'service[monit]'
end
