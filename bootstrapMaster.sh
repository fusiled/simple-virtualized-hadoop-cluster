#!/bin/bash

echo "copying static hosts"
sudo mv -f /home/vagrant/hosts /etc/hosts
chmod 700 .ssh/id_rsa*
chmod +x ./key_scan.sh

echo "disabling selinux"
echo "SELINUX=disabled" > /etc/selinux/config
echo "SELINUXTYPE=targeted" >> /etc/selinux/config
#adding repo
sudo yum install epel-release yum-utils -y
sudo yum install unzip wget ansible git -y
sudo yum-config-manager --add-repo https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/cloudera-cdh5.repo
sudo yum-config-manager --enable cloudera-cdh5

echo "installing oracle-java"
sudo yum localinstall jdk-8u121-linux-x64.rpm -y

echo "enabling root ssh"
sudo cp -dfr /home/vagrant/.ssh  /root/.ssh
sudo sed -i -e "\\#PermitRootLogin without-password# s#PermitRootLogin without-password#PermitRootLogin without-password#g" /etc/ssh/sshd_config
service sshd restart
git clone https://github.com/sergevs/ansible-cloudera-hadoop

sudo chown -R vagrant.vagrant ansible-cloudera-hadoop

#setting remote_user = root in /etc/ansible/ansible.cfg
sudo sed -i '/remote_user = root/s/^#//g' /etc/ansible/ansible.cfg
cd ansible-cloudera-hadoop
echo "Fixing ansible-cloudera-hadoop folder"
mv ../ansHosts ./hosts
mv ../ansAll ./group_vars/all
echo "Rebooting."

sudo reboot



