case node['platform_family']
when 'windows'
  default['smm_mysql']['windows']['package_file']       = "mysql-#{mysql['version']}-#{mysql['arch']}.msi"
  default['smm_mysql']['windows']['packages']           = ['MySQL Server 5.5']
  default['smm_mysql']['windows']['url']                = "http://www.mysql.com/get/Downloads/MySQL-5.5/#{mysql['package_file']}/from/http://mysql.mirrors.pair.com/"
  default['smm_mysql']['windows']['version']            = '5.5.32'
#  default['smm_mysql']['windows']['arch']              = 'win32'

  default['smm_mysql']['windows']['basedir']            = "#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\MySQL\\#{mysql['server']['packages'].first}"
  default['smm_mysql']['windows']['data_dir']           = "#{node['smm_mysql']['windows']['basedir']}\\Data"
  default['smm_mysql']['windows']['bin_dir']            = "#{node['smm_mysql']['windows']['basedir']}\\bin"
  default['smm_mysql']['windows']['mysqladmin_bin']     = "#{node['smm_mysql']['windows']['bin_dir']}\\mysqladmin"
  default['smm_mysql']['windows']['mysql_bin']          = "#{node['smm_mysql']['windows']['bin_dir']}\\mysql"

  default['smm_mysql']['windows']['conf_dir']           = node['smm_mysql']['windows']['basedir']
  default['smm_mysql']['windows']['old_passwords']      = 0
  default['smm_mysql']['windows']['grants_path']        = "#{node['smm_mysql']['conf_dir']}\\grants.sql"

  default['smm_mysql']['server']['service_name']        = 'mysql'
  else
    # type code here
end
