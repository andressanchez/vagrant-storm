# -*- mode: ruby -*-
# vi: set ft=ruby :

#################################
## 1. Set Zookeeper settings   ##
#################################

zookeeper_vm = []
zookeeper_ip = '192.168.2.10'
zookeeper_vm << {'name' => 'zookeeper',
                 'ip' => zookeeper_ip} 

#################################
## 2. Set Nimbus settings      ##
#################################

nimbus_vm = []
nimbus_ip = '192.168.2.11'
nimbus_vm << {'name' => 'nimbus',
              'ip' => nimbus_ip} 

#################################
## 3. Set Supervisors settings ##
#################################

supervisor_count = 2
storm_network = '192.168.2.'
first_supervisor_ip = 12

supervisors_vm = []

(0..supervisor_count-1).each do |i|
  name = 'supervisor' + (i + 1).to_s
  supervisor_ip = storm_network + (first_supervisor_ip + i).to_s
  supervisors_vm << {'name' => name,
                     'ip' => supervisor_ip}
end

#################################
## 4. Setup VMs                ##
#################################

Vagrant.configure("2") do |config|

	zookeeper_vm.each do |zookeeper_vm|
		config.vm.define zookeeper_vm['name'] do |config2|
			config2.vm.box = "precise"
			config2.vm.box_url = "http://files.vagrantup.com/precise64.box"
			config2.vm.provider :virtualbox do |v|
				v.customize ["modifyvm", :id, "--memory", 1024]
				v.customize ["modifyvm", :id, "--cpus", 1]
				v.customize ["modifyvm", :id, "--ioapic", "on"]
			end
			config2.vm.host_name = zookeeper_vm['name']
			config2.vm.network :private_network, ip: zookeeper_vm['ip']
			config2.vm.provision "shell", path: "scripts/install-zookeeper.sh"
			config2.vm.provision :shell, :inline => "gem install chef --version 11.4.2 --no-rdoc --no-ri --conservative"
			config2.vm.provision :chef_solo do |chef|
				chef.log_level = :debug
				chef.cookbooks_path = ["vagrant/cookbooks", "vagrant/site-cookbooks"]
				chef.add_recipe "updater"
				chef.add_recipe "java"
			end
		end
	end

	nimbus_vm.each do |nimbus_vm|
		config.vm.define nimbus_vm['name'] do |config2|
			config2.vm.box = "precise"
			config2.vm.box_url = "http://files.vagrantup.com/precise64.box"
			config2.vm.provider :virtualbox do |v|
				v.customize ["modifyvm", :id, "--memory", 1024]
				v.customize ["modifyvm", :id, "--cpus", 2]
				v.customize ["modifyvm", :id, "--ioapic", "on"]
			end
			config2.vm.host_name = nimbus_vm['name']
			config2.vm.network :private_network, ip: nimbus_vm['ip']
			config2.vm.network "forwarded_port", guest: 8080, host: 8080
			config2.vm.provision :shell, :inline => "gem install chef --version 11.4.2 --no-rdoc --no-ri --conservative"
			config2.vm.provision :chef_solo do |chef|
				chef.log_level = :debug
				chef.cookbooks_path = ["vagrant/cookbooks", "vagrant/site-cookbooks"]
				chef.add_recipe "updater"
				chef.add_recipe "java"
			end
			config2.vm.provision "shell", path: "scripts/install-storm.sh"
			config2.vm.provision "shell", path: "scripts/configure-supervisord.sh", args: "nimbus"
			config2.vm.provision "shell", path: "scripts/configure-supervisord.sh", args: "ui"
			config2.vm.provision "shell", path: "scripts/configure-supervisord.sh", args: "drpc"
			config2.vm.provision "shell", path: "scripts/start-supervisord.sh"
		end
	end
  
	supervisors_vm.each do |supervisors_vm|
		config.vm.define supervisors_vm['name'] do |config2|
			config2.vm.box = "precise"
			config2.vm.box_url = "http://files.vagrantup.com/precise64.box"
			config2.vm.provider :virtualbox do |v|
				v.customize ["modifyvm", :id, "--memory", 1024]
				v.customize ["modifyvm", :id, "--cpus", 2]
				v.customize ["modifyvm", :id, "--ioapic", "on"]
			end
			config2.vm.host_name = supervisors_vm['name']
			config2.vm.network :private_network, ip: supervisors_vm['ip']
			config2.vm.provision :shell, :inline => "gem install chef --version 11.4.2 --no-rdoc --no-ri --conservative"
			config2.vm.provision :chef_solo do |chef|
				chef.log_level = :debug
				chef.cookbooks_path = ["vagrant/cookbooks", "vagrant/site-cookbooks"]
				chef.add_recipe "updater"
				chef.add_recipe "java"
			end
			config2.vm.provision "shell", path: "scripts/install-storm.sh"
			config2.vm.provision "shell", path: "scripts/configure-supervisord.sh", args: "supervisor"
			config2.vm.provision "shell", path: "scripts/configure-supervisord.sh", args: "logviewer"
			config2.vm.provision "shell", path: "scripts/start-supervisord.sh"
		end
	end
end
