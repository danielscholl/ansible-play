#!/usr/bin/env bash
# Copyright (c) 2017, cloudcodeit.com
#
#  Purpose: Delete the Vagrant Resources
#  Usage:
#    localclean.sh <unique> <count>


###############################
## ARGUMENT INPUT            ##
###############################
usage() { echo "Usage: install.sh <unique> <count>" 1>&2; exit 1; }

if [ -f ~/.azure/.env ]; then source ~/.azure/.env; fi
if [ -f ./.env ]; then source ./.env; fi

if [ ! -z $1 ]; then UNIQUE=$1; fi
if [ -z $UNIQUE ]; then
  tput setaf 1; echo 'ERROR: UNIQUE not found' ; tput sgr0
  usage;
fi

if [ ! -z $2 ]; then COUNT=$2; fi
if [ -z $COUNT ]; then
  tput setaf 1; echo 'ERROR: COUNT not found' ; tput sgr0
  usage;
fi

###############################
## Vagrant Destroy           ##
###############################
tput setaf 2; echo 'Destroying Vagrant Machines...' ; tput sgr0
unique=$1 count=$2 vagrant destroy

