default['nodejs-setup']['version'] = '4.x'
default['nodejs-setup']['prefix'] = 'https://deb.nodesource.com/setup_'

case node['flatform_family']
when 'debian'
  default['nodejs-setup']['prefix'] = 'https://deb.nodesource.com/setup_'
when 'fedora', 'rhel'
  default['nodejs-setup']['prefix'] = 'https://rpm.nodesource.com/setup_'
else
  default['nodejs-setup']['prefix'] = nil
end