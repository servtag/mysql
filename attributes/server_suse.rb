case node['platform_family']
when 'suse'
  default['smm_mysql']['data_dir']                = '/var/lib/mysql'
  default['smm_mysql']['server']['service_name']            = 'mysql'
  default['smm_mysql']['server']['server']['packages']      = %w[mysql-community-server]
  default['smm_mysql']['server']['basedir']                 = '/usr'
  default['smm_mysql']['server']['root_group']              = 'root'
  default['smm_mysql']['server']['mysqladmin_bin']          = '/usr/bin/mysqladmin'
  default['smm_mysql']['server']['mysql_bin']               = '/usr/bin/mysql'
  default['smm_mysql']['server']['conf_dir']                = '/etc'
  default['smm_mysql']['server']['confd_dir']               = '/etc/mysql/conf.d'
  default['smm_mysql']['server']['socket']                  = '/var/run/mysql/mysql.sock'
  default['smm_mysql']['server']['pid_file']                = '/var/run/mysql/mysqld.pid'
  default['smm_mysql']['server']['old_passwords']           = 1
  default['smm_mysql']['server']['grants_path']             = '/etc/mysql_grants.sql'
  else
    # type code here
end
