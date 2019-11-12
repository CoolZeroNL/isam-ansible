#!/bin/bash

# Install OS pre-requisites
yum -y update; yum clean all
yum -y install epel-release; yum clean all
yum -y install nano unzip gcc curl openssl-devel openssh-client git python python-pip python-crypto python-ldap python-devel; yum clean all

# Install/Update Python modules
pip install --upgrade pip requests ansible
pip install --upgrade git+https://github.com/ibm-security/ibmsecurity#egg=ibmsecurity

# Remove packages to save space
# yum -y remove epel-release gcc openssl-devel

# Prepare Ansible environment
mkdir /etc/ansible/ /ansible /etc/ansible/roles/
echo "[local]" >> /etc/ansible/hosts
echo "localhost" >> /etc/ansible/hosts

mkdir -p /ansible/playbooks

# Prepare ISAM Ansible Common Roles 
ansible-galaxy install -c -p /etc/ansible/roles git+https://github.com/ibm-security/isam-ansible-roles.git 

ansible-galaxy install -c -p /etc/ansible/roles git+https://github.com/IBM-Security/isds-ansible-roles.git

if [[ -z "${ANSIBLE_ROLES_PATH}"] ]; then
  
  echo 'ANSIBLE_GATHERING=smart' >> /etc/bashrc
  echo 'ANSIBLE_HOST_KEY_CHECKING=false' >> /etc/bashrc
  echo 'ANSIBLE_RETRY_FILES_ENABLED=false' >> /etc/bashrc
  echo 'ANSIBLE_ROLES_PATH=/etc/ansible/roles/isam-ansible-roles' >> /etc/bashrc
  echo 'ANSIBLE_ROLES_PATH=/etc/ansible/roles/isds-ansible-roles:$ANSIBLE_ROLES_PATH' >> /etc/bashrc
  echo 'ANSIBLE_SSH_PIPELINING=True' >> /etc/bashrc
  echo 'PYTHONPATH=/ansible/lib' >> /etc/bashrc
  echo 'PATH=/ansible/bin:$PATH' >> /etc/bashrc

fi

# To load the new environment variables into the current shell session use the source command:
source ~/.bashrc
