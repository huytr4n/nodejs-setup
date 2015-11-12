log 'install npm packages'

# install npm packages
if node['nodejs-setup']['npm_packages']
  packages = node['nodejs-setup']['npm_packages']

  packages.each do |name|
    bash 'setup npm package' do
      log 'Install node package #{name}'
      code <<-EOH
        sudo npm install -g #{name}
        EOH
        only_if { which(name).nil? }
    end
  end
end
