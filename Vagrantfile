# -*- mode: ruby -*-
# vi: set ft=ruby :

MASTER_IP = '192.168.52.4'
NODE1_IP  = '192.168.52.5'
NODE2_IP  = '192.168.52.6'

Vagrant.configure("2") do |config|

  config.vm.define "no1" do |no1|
    no1.vm.hostname = "no1"
    no1.vm.box = "bento/centos-6.7"
    no1.vm.network "private_network", ip: NODE1_IP
    no1.ssh.insert_key = false
    no1.ssh.private_key_path = ["keys/id_rsa", "~/.vagrant.d/insecure_private_key"]
    no1.vm.provision "file", source: "keys/id_rsa.pub", destination: "~/.ssh/authorized_keys"
    no1.vm.provision "file", source: "keys/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    no1.vm.provision "file", source: "keys/id_rsa", destination: "~/.ssh/id_rsa"
    no1.vm.provision "file", source: "files/sshd_config", destination: "~/sshd_config"
    no1.vm.provision "file", source: "files/hosts", destination: "~/hosts"
    no1.vm.provision "shell",inline: "sudo mv -f /home/vagrant/sshd_config /etc/ssh/sshd_config"
    no1.vm.provider "virtualbox" do |v|
      v.name = "no1"
      v.cpus = 1
      v.memory = 512
    end
    no1.vm.provision "shell", path: "bootstrapNode.sh"
  end

  config.vm.define "no2" do |no2|
    no2.vm.hostname = "no2"
    no2.vm.box = "bento/centos-6.7"
    no2.vm.network "private_network", ip: NODE2_IP
    no2.ssh.insert_key = false
    no2.ssh.private_key_path = ["keys/id_rsa", "~/.vagrant.d/insecure_private_key"]
    no2.vm.provision "file", source: "keys/id_rsa.pub", destination: "~/.ssh/authorized_keys"
    no2.vm.provision "file", source: "keys/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    no2.vm.provision "file", source: "keys/id_rsa", destination: "~/.ssh/id_rsa"
    no2.vm.provision "file", source: "files/sshd_config", destination: "~/sshd_config"
    no2.vm.provision "file", source: "files/hosts", destination: "~/hosts"
    no2.vm.provision "shell",inline: "sudo mv -f /home/vagrant/sshd_config /etc/ssh/sshd_config"
    no2.vm.provider "virtualbox" do |v|
      v.name = "no2"
      v.cpus = 1
      v.memory = 512
    end
    no2.vm.provision "shell", path: "bootstrapNode.sh"
  end

  config.vm.define "mas" do |mas|
    mas.vm.hostname = "mas"
    mas.vm.box = "bento/centos-6.7"
    mas.vm.network "private_network", ip: MASTER_IP
    mas.ssh.insert_key = false
    mas.ssh.private_key_path = ["keys/id_rsa", "~/.vagrant.d/insecure_private_key"]
    mas.vm.provision "file", source: "keys/id_rsa.pub", destination: "~/.ssh/authorized_keys"
    mas.vm.provision "file", source: "keys/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    mas.vm.provision "file", source: "keys/id_rsa", destination: "~/.ssh/id_rsa"
    mas.vm.provision "file", source: "files/sshd_config", destination: "~/sshd_config"
    mas.vm.provision "file", source: "files/hosts", destination: "~/hosts"
    mas.vm.provision "file", source: "files/ansAll", destination: "~/ansAll"
    mas.vm.provision "file", source: "files/ansHosts", destination: "~/ansHosts"
    mas.vm.provision "shell",inline: "sudo mv -f /home/vagrant/sshd_config /etc/ssh/sshd_config"
    mas.vm.provider "virtualbox" do |v|
      v.name = "mas"
      v.cpus = 1
      v.memory = 512
    end
    mas.vm.provision "shell", path: "bootstrapMaster.sh"
  end

end
