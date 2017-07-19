# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

require 'yaml'
settings = YAML.load_file 'vagrant.yml'

Vagrant.configure("2") do |config|

  # setup the ansible inventory file
  ansible_inventory_dir = "ansible/hosts"
  Dir.mkdir(ansible_inventory_dir) unless Dir.exist?(ansible_inventory_dir)
  File.open("#{ansible_inventory_dir}/vagrant" ,'w') do |f|
    f.write "[#{settings['vm_name']}]\n"
    f.write "#{settings['ip_address']} "
    f.write "ansible_python_interpreter=/usr/bin/python3\n"
  end

  # setup the ansible cfg file
  File.open("ansible.cfg" ,'w') do |f|
    f.write "[defaults]\n"
    f.write "inventory = #{ansible_inventory_dir}/vagrant\n"
    f.write "private_key_file = ~/ansible/.vagrant/machines/default/virtualbox/private_key\n"
    f.write "host_key_checking = false\n"
    f.write "remote_user = ubuntu\n"
  end

  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "jumpserver"
  config.vm.network :private_network, ip: settings['ip_address']
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443


  config.vm.provision "ansible" do |ansible|
    #ansible.verbose = "v"
    ansible.playbook = "ansible/playbook.yml"
    ansible.inventory_path = "#{ansible_inventory_dir}/vagrant"
    ansible.limit = 'all'
    ansible.extra_vars = {
      private_interface: "192.168.33.66",
      hostname: "jumpserver",
    }
  end
end
