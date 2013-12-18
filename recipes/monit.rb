include_recipe 'smm_monit::default'

template '/etc/monit/conf.d/mysql.monitrc' do
  source 'mysql.monitrc.erb'
  mode 0644
  notifies :restart, 'service[monit]'
end
