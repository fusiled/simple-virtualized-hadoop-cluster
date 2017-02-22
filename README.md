
#Simple Virtualized Hadoop Cluster

##Requirements

vagrant, ssh and virtualbox (Version 5 or higher) on host machine.

##Steps

1. Launch run.sh and wait for the setup of the machines
2. Log in mas machine with ssh with user vagrant.
3. from mas ssh mas, no1 and no2, so mas will be added to known_hosts
 (future commits will fix this issue automatically)
4. go in ansible-cloudera-hadoop directory and launch the following 
command:
	ansible-playbook -i hosts site.yaml
and wait for the cluster installation
