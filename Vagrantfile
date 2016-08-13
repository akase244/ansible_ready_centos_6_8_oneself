# -*- mode: ruby -*-
# vi: set ft=ruby :

#VM_BOX = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.7_chef-provisionerless.box"
VM_BOX = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.8_chef-provisionerless.box"
VM_IP = "192.168.33.101"

Vagrant.configure(2) do |config|
  config.vm.box = VM_BOX

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 22, host: 2101, id: "ssh"

  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network :private_network, ip: VM_IP

  # config.vm.synced_folder "../data", "/vagrant_data"

  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
  config.vm.provision :shell do |shell|
    shell.path = "provision.sh"
    shell.privileged = false
  end

  config.ssh.forward_agent = true
end
