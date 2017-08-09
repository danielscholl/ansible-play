# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

count = ENV['count'] || 1
unique = ENV['unique'] || 'vm'


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provider "virtualbox" do |vb|
     vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
  end

  config.vm.network "private_network", type: "dhcp"

  nodes = count.to_i
  (1..nodes).each do |i|
    config.vm.define "#{unique}#{i}" do |node|
      node.vm.hostname = "#{unique}#{i}"

      # Add a SATA controlle with 30 ports to the VM, so REX-Ray can add disks on the fly
      node.vm.provider :virtualbox do |vb|
       vb.customize ["storagectl", :id, "--add", "sata", "--controller", "IntelAhci", "--name", "SATA", "--portcount", 30, "--hostiocache", "on"]
       vb.customize ["modifyvm", :id, "--macaddress1", "auto"]
      end

      # Set the current $PWD as the place where you will
      # store the VMDKs that are attached to the VM.
      dir = "#{ENV['PWD']}/Volumes"
      node.vm.provision "ansible" do |ansible|
        #ansible.verbose = "v"
        ansible.playbook = "ansible/playbooks/initServer.yml"
        ansible.limit = 'all'
        ansible.extra_vars = {
          hostname: "#{unique}#{i}"
        }
      end

    end
  end
end
