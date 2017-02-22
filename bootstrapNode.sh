#!/bin/bash

echo "copying static hosts"
sudo mv -f /home/vagrant/hosts /etc/hosts
chmod 700 .ssh/id_rsa*

echo "disabling selinux"
echo "SELINUX=disabled" > /etc/selinux/config
echo "SELINUXTYPE=targeted" >> /etc/selinux/config
#adding repo
sudo yum install epel-release yum-utils -y
sudo yum install unzip wget git -y
sudo yum-config-manager --add-repo https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/cloudera-cdh5.repo
sudo yum-config-manager --enable cloudera-cdh5

echo "retrieving oracle-java from mas and installing it"
scp  -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null centos@mas:~/jdk-8u121-linux-x64.rpm .
sudo yum localinstall jdk-8u121-linux-x64.rpm -y


echo "enabling root ssh"
sudo cp -dfr /home/vagrant/.ssh  /root/.ssh
sudo sed -i -e "\\#PermitRootLogin without-password# s#PermitRootLogin without-password#PermitRootLogin without-password#g" /etc/ssh/sshd_config
service sshd restart

echo "Rebooting node"

sudo reboot



