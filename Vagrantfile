VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # forward some default ports for elasticsearch, kibana and node express 
  config.vm.network "forwarded_port", guest: 9200, host: 9200
  config.vm.network "forwarded_port", guest: 3001, host: 3001
  config.vm.network "forwarded_port", guest: 5601, host: 5601
  config.ssh.forward_agent = true

  config.vm.synced_folder "./_bootstrap/config", "/home/vagrant/_bootstrap/config"
  config.vm.synced_folder "./sync", "/home/vagrant/sync"

  config.vm.provider "virtualbox" do |box|
    box.gui = false
    # required for elasticsearch
    box.customize ["modifyvm", :id, "--memory", "16384"]
    box.customize ["modifyvm", :id, "--rtcuseutc", "on"]
  end

  config.vm.define "esbox",primary: true do |box|
    box.vm.hostname = "esbox"
    box.vm.box = "ubuntu/focal64"
    
    # box.vm.network :private_network, ip: "9.9.9.9"
    box.vm.provision :shell, :inline => "apt-get update --fix-missing"
    
    # install all privileged dependencies
    box.vm.provision :shell, :path => "_bootstrap/bootstrap.sh"
    
    # install all non-privileged dependencies
    box.vm.provision :shell, :privileged => false, :path => "_bootstrap/bootstrap-non-privileged.sh"
  end
end
