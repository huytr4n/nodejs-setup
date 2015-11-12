# select prefix by os
case node['flatform_family']
when 'debian'
  log 'prefix with debian'
  node['nodejs-setup']['prefix'] = 'https://deb.nodesource.com/setup_'
when 'fedora', 'rhel'
  log 'prefix with rhel'
  node['nodejs-setup']['prefix'] = 'https://rpm.nodesource.com/setup_'
else
  log 'prefix with others'
  node['nodejs-setup']['prefix'] = nil
end

# version should be 0.10, 0.12, 4.x, 5.x
prefix = node['nodejs-setup']['prefix']
version = node['nodejs-setup']['version']
install_url = [prefix, version].join('')

case node['platform_family']
when 'fedora', 'rhel'
  log 'Installing node with fedora'

  bash "setup node" do
    code <<-EOH
      yum install gcc-c++ make curl -y
      curl --silent --location #{install_url} | bash -
      yum -y install nodejs
      EOH
    not_if { ::File.exists?("/usr/bin/node") }
  end
when 'debian'
  log 'Installing node with debian'

  bash "setup node" do
    code <<-EOH
      sudo apt-get install -y build-essential
      sudo apt-get install curl -y
      curl -sL #{install_url} | sudo -E bash -
      sudo apt-get install -y nodejs
      EOH
    not_if { ::File.exists?("/usr/bin/node") }
  end
else
  log 'Not supported yet!'
end
