#!/usr/bin/env bash

set -euo pipefail

# $WORKSPACE is shared between steps
python3 -m venv $WORKSPACE/virtual/environment
source $WORKSPACE/virtual/environment/bin/activate

# Install ansible
pip3 install --only-binary=:all: ansible
pip3 install ansible==2.9.11

# Install xmltodict required for the z/OS collection ibm.ibm_zos_cics
pip3 install xmltodict 

# Just for test (MUST NOT BE USED EXTERNALY WE MUST USE A SSH KEY)
wget https://rpmfind.net/linux/centos/8-stream/AppStream/x86_64/os/Packages/sshpass-1.09-4.el8.x86_64.rpm
rpm -i sshpass-1.09-4.el8.x86_64.rpm

# Install RedHat Ansible collections for z/OS 
ansible-galaxy collection install ibm.ibm_zos_core
ansible-galaxy collection install ibm.ibm_zos_cics

if [ "$(get_env pipeline_namespace "")" = "cd" ]
then
  echo "No setup when running CD pipeline..."
  exit 0
else
  echo "Running in a CI pipeline..."
fi

#export TOOLCHAIN_CONFIG_JSON="/toolchain/toolchain.json"
#cat $TOOLCHAIN_CONFIG_JSON

TOOLCHAIN_CONFIG_JSON="$(get_env TOOLCHAIN_CONFIG_JSON)"