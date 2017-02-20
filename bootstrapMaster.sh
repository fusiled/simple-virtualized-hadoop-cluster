#!/bin/bash

echo "copying static hosts"
sudo mv -f /home/vagrant/hosts /etc/hosts
chmod 700 .ssh/id_rsa*

echo "disabling selinux"
echo "SELINUX=disabled" > /etc/selinux/config
echo "SELINUXTYPE=targeted" >> /etc/selinux/config
#adding repo
yum install epel-release yum-utils -y
yum install unzip wget ansible git -y
yum-config-manager --add-repo https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/cloudera-cdh5.repo
yum-config-manager --enable cloudera-cdh5

echo "installing oracle-java"
wget -q -nc --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm" -P /vagrant 
yum localinstall /vagrant/jdk-8u121-linux-x64.rpm -y

echo "enabling root ssh"
sudo cp -dfr /home/vagrant/.ssh  /root/.ssh
sudo sed -i -e "\\#PermitRootLogin without-password# s#PermitRootLogin without-password#PermitRootLogin without-password#g" /etc/ssh/sshd_config
service sshd restart
git clone https://github.com/sergevs/ansible-cloudera-hadoop

sudo chown -R vagrant.vagrant ansible-cloudera-hadoop


sudo sed -i '/remote_user = root/s/^#//g' /etc/ansible/ansible.cfg
cd ansible-cloudera-hadoop
echo "Fixing ansible-cloudera-hadoop folder"
mv ../ansHosts ./hosts
mv ../ansAll ./group_vars/all
echo "Rebooting. Now you should be ready to install hadoop. Wait for reboot, then ssh again"

sudo reboot



