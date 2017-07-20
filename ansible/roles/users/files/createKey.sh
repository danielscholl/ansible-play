#!/usr/bin/env bash
# Copyright (c) 2017, cloudcodeit.com
#
#  Purpose: Create a SSH Key
#  Usage:
#    createKey.sh <user>


###############################
## ARGUMENT INPUT            ##
###############################
usage() { echo "Usage: createKey.sh <user>" 1>&2; exit 1; }

if [ -z $1 ]; then
  tput setaf 1; echo 'ERROR: USER not found' ; tput sgr0
  usage;
fi

ssh-keygen -t rsa -b 4096 -C $1 -f id_rsa_$1
