#!/usr/bin/env bash
# Copyright (c) 2017, cloudcodeit.com
#
#  Purpose: Initialize an Azure Virtual Machine for Ansible Play
#  Usage:
#    init.sh <unique>


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
if [ -z ${AZURE_LOCATION} ]; then
  tput setaf 1; echo 'ERROR: Global Variable AZURE_LOCATION not set'; tput sgr0
  exit 1;
fi


###############################
## Azure Intialize           ##
###############################
tput setaf 2; echo 'Logging in and setting subscription...' ; tput sgr0
az account set --subscription ${AZURE_SUBSCRIPTION}


##############################
## Temporary Resource Group ##
##############################
CATEGORY=${PWD##*/}
RESOURCE_GROUP=${UNIQUE}-${CATEGORY}

tput setaf 2; echo "Creating the $RESOURCE_GROUP resource group..." ; tput sgr0
CreateResourceGroup ${RESOURCE_GROUP} ${AZURE_LOCATION};
az group show --name ${RESOURCE_GROUP} -ojsonc

tput setaf 2; echo "Creating the ${UNIQUE} virtual machine..." ; tput sgr0
CreateVirtualMachine ${UNIQUE} ${RESOURCE_GROUP}
az vm show --name ${UNIQUE} --resource-group ${RESOURCE_GROUP} -ojsonc


##############################
## Create Ansible Inventory ##
##############################
HOST=jumpserver
INVENTORY_FILE="ansible/inventories/azure/hosts"

tput setaf 2; echo "'Retrieving IP Address for' ${HOST}..." ; tput sgr0
IP=$(az vm list-ip-addresses --name ${UNIQUE} \
    --resource-group ${RESOURCE_GROUP}  \
    --query [].virtualMachine.network.publicIpAddresses[].ipAddress -otsv)
echo ${IP}
tput setaf 2; echo 'Creating the ansible inventory files...' ; tput sgr0
cat > ${INVENTORY_FILE} << EOF
[jumpserver]
${IP}
EOF

tput setaf 2; echo 'Creating the ansible config file...' ; tput sgr0
cat > ansible.cfg << EOF1
[defaults]
inventory = ${INVENTORY_FILE}
private_key_file = ~/.ssh/id_rsa
host_key_checking = false
EOF1

##########################s
## Run Ansible Playbook ##
##########################
sleep 5
ansible-playbook ansible/playbooks/initServer.yml
