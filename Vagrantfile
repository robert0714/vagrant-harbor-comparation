# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
  else
    config.vm.synced_folder ".", "/vagrant"
  end
  
  config.vm.define "harbor-registry-1" do |d| 
    d.vm.box = "ubuntu/trusty64"
    d.vm.hostname = "harbor-registry-1"
#    d.vm.network "private_network", ip: "10.100.98.200"
    d.vm.network "public_network", bridge: "eno4", ip: "192.168.57.44", auto_config: "false", netmask: "255.255.255.0" , gateway: "192.168.57.1"
    default_router = "192.168.57.1"
    d.vm.provision :shell, inline: "ip route delete default 2>&1 >/dev/null || true; ip route add default via #{default_router}"
    d.vm.provision :shell, path: "scripts/bootstrap_ansible.sh"
    d.vm.provision :shell, inline: "PYTHONUNBUFFERED=1 ansible-playbook /vagrant/ansible/harbor.yml -c local"    
    d.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 2
    end
  end
  config.vm.define "harbor-registry-2" do |d| 
    d.vm.box = "ubuntu/trusty64"
    d.vm.hostname = "harbor-registry-2"
#    d.vm.network "private_network", ip: "10.100.98.200"
    d.vm.network "public_network", bridge: "eno4", ip: "192.168.57.45", auto_config: "false", netmask: "255.255.255.0" , gateway: "192.168.57.1"
    default_router = "192.168.57.1"
    d.vm.provision :shell, inline: "ip route delete default 2>&1 >/dev/null || true; ip route add default via #{default_router}"
    d.vm.provision :shell, path: "scripts/bootstrap_ansible.sh"
    d.vm.provision :shell, inline: "PYTHONUNBUFFERED=1 ansible-playbook /vagrant/ansible/harbor.yml -c local"    
    d.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 2
    end
  end 
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.vbguest.no_install = false
    config.vbguest.no_remote = false
  end
end
