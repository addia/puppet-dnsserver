# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "landregistry/centos"
  config.vm.provision "shell", inline: <<-SCRIPT
    yum install -y git
    git clone https://github.com/mooreandrew/puppet-dns.git /etc/puppet/modules/dns
    puppet module install puppetlabs/concat
    puppet module install electrical/file_concat
    puppet module install puppetlabs/stdlib
    ln -s /vagrant /etc/puppet/modules/dnsserver
    cd /vagrant
  SCRIPT

  config.vm.network "private_network", :ip => "192.168.42.49"

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', ENV['VM_MEMORY'] || 2048]
    vb.customize ["modifyvm", :id, "--cpus", ENV['VM_CPUS'] || 4]
  end
end
