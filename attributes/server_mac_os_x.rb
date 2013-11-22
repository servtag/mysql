case node['platform_family']
when 'mac_os_x'
  default['smm_mysql']['server']['packages']      = %w[mysql]
  default['smm_mysql']['basedir']                 = '/usr/local/Cellar'
  default['smm_mysql']['data_dir']                = '/usr/local/var/mysql'
  default['smm_mysql']['root_group']              = 'admin'
  default['smm_mysql']['mysqladmin_bin']          = '/usr/local/bin/mysqladmin'
  default['smm_mysql']['mysql_bin']               = '/usr/local/bin/mysql'
  else
    # type code here
end
