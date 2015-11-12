# version should be 0.10, 0.12, 4.x, 5.x
source_url = node['nodejs-setup']['prefix']
version = node['nodejs-setup']['version']
install_url = [source_url, version].join('')

log 'Installing node'
log source_url
log version

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
