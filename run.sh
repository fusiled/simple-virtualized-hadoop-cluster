#!/bin/bash

KEYS_DIR="keys"
mkdir -p $KEYS_DIR
echo "Generating keys on your pc (if they don't exist) in $KEYS_DIR directory..."
cat /dev/zero | ssh-keygen -q -N "" -f $KEYS_DIR/id_rsa
echo "--Launching vagrant--"
vagrant up