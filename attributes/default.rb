default['nodejs-setup']['version'] = '4.x'
default['nodejs-setup']['prefix'] = 'https://deb.nodesource.com/setup_'

case node['flatform_family']
when 'debian'
  log 'prefix with debian'
  default['nodejs-setup']['prefix'] = 'https://deb.nodesource.com/setup_'
when 'fedora', 'rhel'
  log 'prefix with rhel'
  default['nodejs-setup']['prefix'] = 'https://rpm.nodesource.com/setup_'
else
  log 'prefix with others'
  default['nodejs-setup']['prefix'] = nil
end