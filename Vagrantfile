# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.7.4"
Vagrant.configure(2) do | global |
  global.vbguest.auto_update = false
end

Vagrant.configure(2) do |config|
  config.vm.box = "landregistry/centos"
  config.vm.provision "shell", inline: <<-SCRIPT
  yum install -y git
  #NB module is also dependant on ajjahn-dns 2.0.1 however there is no forge release for this module at time of writing
  git clone https://github.com/ajjahn/puppet-dns.git /etc/puppet/modules/dns
  cd /etc/puppet/modules/dns
  git checkout c545493603f1a1352db73f49346f9e253d7599aa
  #The following are dependacies of ajjahn-dns 2.0.1
  puppet module install puppetlabs/concat
  puppet module install electrical/file_concat
  puppet module install puppetlabs/stdlib
  ln -s /vagrant /etc/puppet/modules/dnsserver
  gem install librarian-puppet
  cd /vagrant
  /usr/local/bin/librarian-puppet install --verbose
  puppet apply --modulepath=/vagrant/modules:/etc/puppet/modules /etc/puppet/modules/dnsserver/tests/init.pp
  SCRIPT

  config.vm.network "private_network", :ip => "192.168.42.49"

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', ENV['VM_MEMORY'] || 2048]
    vb.customize ["modifyvm", :id, "--cpus", ENV['VM_CPUS'] || 4]
  end
end
