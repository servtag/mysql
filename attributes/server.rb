#
# Cookbook Name:: mysql
# Attributes:: server
#
# Copyright 2008-2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Probably driven from wrapper cookbooks, environments, or roles.
# Keep in this namespace for backwards compat

default['smm_mysql']['port']                       = 3306
default['smm_mysql']['nice']                       = 0

# eventually remove?  where is this used?
if attribute?('ec2')
  default['smm_mysql']['ec2_path']    = '/mnt/mysql'
  default['smm_mysql']['ebs_vol_dev'] = '/dev/sdi'
  default['smm_mysql']['ebs_vol_size'] = 50
end

# actual configs start here
default['smm_mysql']['auto-increment-increment']        = 1
default['smm_mysql']['auto-increment-offset']           = 1

default['smm_mysql']['allow_remote_root']               = false

default['smm_mysql']['remove_test_database']            = false
default['smm_mysql']['root_network_acl']                = nil
default['smm_mysql']['tunable']['character-set-server'] = 'utf8'
default['smm_mysql']['tunable']['collation-server']     = 'utf8_general_ci'
default['smm_mysql']['tunable']['lower_case_table_names']  = nil
default['smm_mysql']['tunable']['back_log']             = '128'
default['smm_mysql']['tunable']['key_buffer_size']           = '256M'
default['smm_mysql']['tunable']['myisam_sort_buffer_size']   = '8M'
default['smm_mysql']['tunable']['myisam_max_sort_file_size'] = '2147483648'
default['smm_mysql']['tunable']['myisam_repair_threads']     = '1'
default['smm_mysql']['tunable']['myisam-recover']            = 'BACKUP'

default['smm_mysql']['tunable']['max_connect_errors']   = '10'
default['smm_mysql']['tunable']['concurrent_insert']    = '2'
default['smm_mysql']['tunable']['connect_timeout']      = '10'
default['smm_mysql']['tunable']['tmp_table_size']       = '32M'
default['smm_mysql']['tunable']['max_heap_table_size']  = node['smm_mysql']['tunable']['tmp_table_size']
default['smm_mysql']['tunable']['bulk_insert_buffer_size'] = node['smm_mysql']['tunable']['tmp_table_size']
default['smm_mysql']['tunable']['net_read_timeout']     = '30'
default['smm_mysql']['tunable']['net_write_timeout']    = '30'

default['smm_mysql']['tunable']['thread_cache_size']    = 8
default['smm_mysql']['tunable']['thread_concurrency']   = 10

default['smm_mysql']['tunable']['sort_buffer_size']     = '2M'
default['smm_mysql']['tunable']['read_buffer_size']     = '128k'
default['smm_mysql']['tunable']['read_rnd_buffer_size'] = '256k'
default['smm_mysql']['tunable']['join_buffer_size']     = '128k'
default['smm_mysql']['tunable']['wait_timeout']         = '180'
default['smm_mysql']['tunable']['open-files-limit']     = '1024'

default['smm_mysql']['tunable']['sql_mode'] = nil

default['smm_mysql']['tunable']['skip-character-set-client-handshake'] = false
default['smm_mysql']['tunable']['skip-name-resolve']                   = false

default['smm_mysql']['tunable']['slave_compressed_protocol']       = 0

default['smm_mysql']['tunable']['server_id']                       = nil
default['smm_mysql']['tunable']['log_bin']                         = nil
default['smm_mysql']['tunable']['log_bin_trust_function_creators'] = false

default['smm_mysql']['tunable']['relay_log']                       = nil
default['smm_mysql']['tunable']['relay_log_index']                 = nil
default['smm_mysql']['tunable']['log_slave_updates']               = false

default['smm_mysql']['tunable']['replicate_do_db']             = nil
default['smm_mysql']['tunable']['replicate_do_table']          = nil
default['smm_mysql']['tunable']['replicate_ignore_db']         = nil
default['smm_mysql']['tunable']['replicate_ignore_table']      = nil
default['smm_mysql']['tunable']['replicate_wild_do_table']     = nil
default['smm_mysql']['tunable']['replicate_wild_ignore_table'] = nil

default['smm_mysql']['tunable']['sync_binlog']                     = 0
default['smm_mysql']['tunable']['skip_slave_start']                = false
default['smm_mysql']['tunable']['read_only']                       = false

default['smm_mysql']['tunable']['log_error']                       = nil
default['smm_mysql']['tunable']['log_warnings']                    = false
default['smm_mysql']['tunable']['log_queries_not_using_index']     = true
default['smm_mysql']['tunable']['log_bin_trust_function_creators'] = false

default['smm_mysql']['tunable']['innodb_log_file_size']            = '5M'

default['smm_mysql']['tunable']['innodb_buffer_pool_instances']    = '4'

default['smm_mysql']['tunable']['innodb_data_file_path']           = 'ibdata1:10M:autoextend'
default['smm_mysql']['tunable']['innodb_flush_method']             = false
default['smm_mysql']['tunable']['innodb_log_buffer_size']          = '8M'
default['smm_mysql']['tunable']['innodb_write_io_threads']         = '4'
default['smm_mysql']['tunable']['innodb_io_capacity']              = '200'
default['smm_mysql']['tunable']['innodb_file_per_table']           = true
default['smm_mysql']['tunable']['innodb_lock_wait_timeout']        = '60'
if node['cpu'].nil? || node['cpu']['total'].nil?
  default['smm_mysql']['tunable']['innodb_thread_concurrency']       = '8'
  default['smm_mysql']['tunable']['innodb_commit_concurrency']       = '8'
  default['smm_mysql']['tunable']['innodb_read_io_threads']          = '8'
else
  default['smm_mysql']['tunable']['innodb_thread_concurrency']       = (node['cpu']['total'].to_i * 2).to_s
  default['smm_mysql']['tunable']['innodb_commit_concurrency']       = (node['cpu']['total'].to_i * 2).to_s
  default['smm_mysql']['tunable']['innodb_read_io_threads']          = (node['cpu']['total'].to_i * 2).to_s
end
default['smm_mysql']['tunable']['innodb_flush_log_at_trx_commit']  = '1'
default['smm_mysql']['tunable']['innodb_support_xa']               = true
default['smm_mysql']['tunable']['innodb_table_locks']              = true
default['smm_mysql']['tunable']['skip-innodb-doublewrite']         = false

default['smm_mysql']['tunable']['transaction-isolation'] = nil

default['smm_mysql']['tunable']['query_cache_limit']    = '1M'
default['smm_mysql']['tunable']['query_cache_size']     = '16M'

default['smm_mysql']['tunable']['long_query_time']      = 2
default['smm_mysql']['tunable']['expire_logs_days']     = 10
default['smm_mysql']['tunable']['max_binlog_size']      = '100M'
default['smm_mysql']['tunable']['binlog_cache_size']    = '32K'

default['smm_mysql']['tmpdir'] = %w(/tmp)

# default['smm_mysql']['log_dir'] = node['smm_mysql']['data_dir']
default['smm_mysql']['log_files_in_group'] = false
default['smm_mysql']['innodb_status_file'] = false

unless node['platform_family'] == 'rhel' && node['platform_version'].to_i < 6
  # older RHEL platforms don't support these options
  default['smm_mysql']['tunable']['event_scheduler']  = 0
  default['smm_mysql']['tunable']['binlog_format']    = 'statement' if node['smm_mysql']['tunable']['log_bin']
end

# security options
# @see http://www.symantec.com/connect/articles/securing-mysql-step-step
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_chroot
default['smm_mysql']['security']['chroot']                  = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_safe-user-create
default['smm_mysql']['security']['safe_user_create']        = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_secure-auth
default['smm_mysql']['security']['secure_auth']             = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_symbolic-links
default['smm_mysql']['security']['skip_symbolic_links']     = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_secure-file-priv
default['smm_mysql']['security']['secure_file_priv']        = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_skip-show-database
default['smm_mysql']['security']['skip_show_database']      = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_local_infile
default['smm_mysql']['security']['local_infile']            = nil

#smm customizations
if node.attribute?('cloud') && node['cloud']['local_ipv4']
  default['smm_mysql']['bind_address'] = node['cloud']['local_ipv4']
else
  default['smm_mysql']['bind_address'] = node[:opsworks][:instance][:private_ip]
end

if (memory_total = node.memory.total.split('kB').first.to_i/1000)
  if memory_total > 15000
    innodb_buffer_pool_size = '10240M'
  elsif memory_total > 4000
    innodb_buffer_pool_size = '2048M'
  elsif memory_total > 1024
    innodb_buffer_pool_size = '1024M'
  else
    innodb_buffer_pool_size = '128M'
  end
else
  innodb_buffer_pool_size = '128M'
end

default['smm_mysql']['tunable']['innodb_buffer_pool_size']         = innodb_buffer_pool_size
default['smm_mysql']['tunable']['innodb_additional_mem_pool_size'] = '20M'
default['smm_mysql']['tunable']['max_allowed_packet']              = '32M'
default['smm_mysql']['tunable']['max_connections']                 = '2048'
default['smm_mysql']['tunable']['table_cache']                     = '2048'
default['smm_mysql']['tunable']['table_open_cache']                = node['smm_mysql']['tunable']['table_cache']
default['smm_mysql']['tunable']['thread_stack']                    = '192K'
default['smm_mysql']['remove_anonymous_users']                     = true

#smm additions
default['smm_mysql']['tunable']['innodb_file_format']              = 'barracuda'
default['smm_mysql']['tunable']['group_concat_max_len']            = '5000000'
default['smm_mysql']['tunable']['event_scheduler']                 = 'on'

include_attribute 'rad_archive::default'
include_attribute 'rad_report::default'
include_attribute 'dealomio_management_api::default'
