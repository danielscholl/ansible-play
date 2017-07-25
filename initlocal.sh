#!/usr/bin/env bash
# Copyright (c) 2017, cloudcodeit.com
#
#  Purpose: Initialize an Azure Virtual Machine for Ansible Play
#  Usage:
#    init.sh <unique> <server_count>


###############################
## ARGUMENT INPUT            ##
###############################
usage() { echo "Usage: init.sh <unique>" 1>&2; exit 1; }

if [ -f ~/.azure/.env ]; then source ~/.azure/.env; fi
if [ -f ./.env ]; then source ./.env; fi
if [ -f ./functions.sh ]; then source ./functions.sh; fi


if [ ! -z $1 ]; then UNIQUE=$1; fi
if [ -z $UNIQUE ]; then
  tput setaf 1; echo 'ERROR: UNIQUE not found' ; tput sgr0
  usage;
fi

if [ ! -z $2 ]; then COUNT=$2; fi
if [ -z $COUNT ]; then
  COUNT=1
fi

###############################
## Vagrant Intialize         ##
###############################
tput setaf 2; echo 'Installing Vagrant Machines...' ; tput sgr0
unique=$1 count=$2 vagrant up


##############################
## Create Ansible Inventory ##
##############################
INVENTORY="./ansible/inventories/vagrant"
mkdir -p ${INVENTORY};

tput setaf 2; echo "Retrieving IP Address ..." ; tput sgr0
tput setaf 2; echo 'Creating the ansible inventory files...' ; tput sgr0

cat > ${INVENTORY}/hosts << EOF
$(unique=$1 count=$2 ./inventory.py)
EOF

tput setaf 2; echo 'Creating the ansible config file...' ; tput sgr0
cat > ansible.cfg << EOF1
[defaults]
inventory = ${INVENTORY}/hosts
remote_user = ubuntu
host_key_checking = false
EOF1
