#!/bin/bash

KEYS_DIR="keys"
mkdir -p $KEYS_DIR
echo "Generating keys on your pc (if they don't exist) in $KEYS_DIR directory..."
cat /dev/zero | ssh-keygen -q -N "" -f $KEYS_DIR/id_rsa
echo "downloading java if it's not present"
wget -nc --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm" -P files
echo "--Launching vagrant--"
vagrant up
echo "Vagrant has finished its tasks... adding nodes to mas known_hosts. But we must wait for no2 reboot. Waiting 1 minute"
sleep 60
mas_port=$(vagrant ssh-config mas | grep Port | grep -o "[0-9]\{1,\}")
ssh -i $KEYS_DIR/id_rsa -p $mas_port vagrant@127.0.0.1 "./key_scan.sh"

echo "++++VAGRANT INSTALLATION COMPLETED!++++"

ssh -i $KEYS_DIR/id_rsa -p $mas_port vagrant@127.0.0.1 "cd ansible-cloudera-hadoop && ansible-playbook -i hosts site.yaml"

echo "Please, log into mas machine with the following command:"
echo "   ssh -p $mas_port vagrant@127.0.0.1 -i $KEYS_DIR/id_rsa"