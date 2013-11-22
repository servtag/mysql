case node['platform_family']
when 'rhel'

  # Probably driven from wrapper cookbooks, environments, or roles.
  # Keep in this namespace for backwards compat
  default['smm_mysql']['data_dir'] = '/var/lib/mysql'

  # switching logic to account for differences in platform native
  # package versions
  case node['platform_version'].to_i
  when 5
    default['smm_mysql']['server']['packages'] = %w(mysql-server)
    default['smm_mysql']['server']['log_slow_queries']     = '/var/log/mysql/slow.log'
  when 6
    default['smm_mysql']['server']['packages'] = %w(mysql-server)
    default['smm_mysql']['server']['slow_query_log']       = 1
    default['smm_mysql']['server']['slow_query_log_file']  = '/var/log/mysql/slow.log'
  when 2013 # amazon linux
    default['smm_mysql']['server']['packages'] = %w(mysql-server)
    default['smm_mysql']['server']['slow_query_log']       = 1
    default['smm_mysql']['server']['slow_query_log_file']  = '/var/log/mysql/slow.log'
    else
      # type code here
  end

  # Platformisms.. filesystem locations and such.
  default['smm_mysql']['server']['basedir'] = '/usr'
  default['smm_mysql']['server']['tmpdir'] = %w(/tmp)

  default['smm_mysql']['server']['directories']['run_dir']              = '/var/run/mysqld'
  default['smm_mysql']['server']['directories']['log_dir']              = '/var/lib/mysql'
  default['smm_mysql']['server']['directories']['slow_log_dir']         = '/var/log/mysql'
  default['smm_mysql']['server']['directories']['confd_dir']            = '/etc/mysql/conf.d'

  default['smm_mysql']['server']['mysqladmin_bin']       = '/usr/bin/mysqladmin'
  default['smm_mysql']['server']['mysql_bin']            = '/usr/bin/mysql'

  default['smm_mysql']['server']['pid_file']             = '/var/run/mysqld/mysqld.pid'
  default['smm_mysql']['server']['socket']               = '/var/lib/mysql/mysql.sock'
  default['smm_mysql']['server']['grants_path']          = '/etc/mysql_grants.sql'
  default['smm_mysql']['server']['old_passwords']        = 1

  # RHEL/CentOS mysql package does not support this option.
  default['smm_mysql']['tunable']['innodb_adaptive_flushing'] = false
  default['smm_mysql']['server']['skip_federated'] = false
  else
    # type code here
end
