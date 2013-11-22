case node['platform_family']

when 'freebsd'
  default['smm_mysql']['data_dir']                = '/var/db/mysql'
  default['smm_mysql']['server']['packages']      = %w[mysql55-server]
  default['smm_mysql']['server']['service_name']  = 'mysql-server'
  default['smm_mysql']['server']['basedir']       = '/usr/local'
  default['smm_mysql']['server']['root_group']              = 'wheel'
  default['smm_mysql']['server']['mysqladmin_bin']          = '/usr/local/bin/mysqladmin'
  default['smm_mysql']['server']['mysql_bin']               = '/usr/local/bin/mysql'
  default['smm_mysql']['server']['conf_dir']                = '/usr/local/etc'
  default['smm_mysql']['server']['confd_dir']               = '/usr/local/etc/mysql/conf.d'
  default['smm_mysql']['server']['socket']                  = '/tmp/mysqld.sock'
  default['smm_mysql']['server']['pid_file']                = '/var/run/mysqld/mysqld.pid'
  default['smm_mysql']['server']['old_passwords']           = 0
  default['smm_mysql']['server']['grants_path']             = '/var/db/mysql/grants.sql'
  else
    # type code here
end
