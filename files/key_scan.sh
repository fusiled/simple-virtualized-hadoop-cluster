#!bin/bash
echo "adding keys to .ssh/known_hosts"
ssh-keyscan mas >> ~/.ssh/known_hosts
ssh-keyscan no1 >> ~/.ssh/known_hosts
ssh-keyscan no2 >> ~/.ssh/known_hosts