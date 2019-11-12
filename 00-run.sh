#!/bin/bash

# Install OS pre-requisites
yum -y update; yum clean all
yum -y install epel-release; yum clean all
yum -y install unzip gcc curl openssl-devel openssh-client git python python-pip python-crypto python-ldap python-devel; yum clean all

# Install/Update Python modules
pip install --upgrade pip requests ansible
pip install --upgrade git+https://github.com/ibm-security/ibmsecurity#egg=ibmsecurity

# Remove packages to save space
yum -y remove epel-release gcc openssl-devel

# Prepare Ansible environment
mkdir /etc/ansible/ /ansible /etc/ansible/roles/
echo "[local]" >> /etc/ansible/hosts
echo "localhost" >> /etc/ansible/hosts

mkdir -p /ansible/playbooks

# Prepare ISAM Ansible Common Roles 
ansible-galaxy install -c -p /etc/ansible/roles git+https://github.com/ibm-security/isam-ansible-roles.git 

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /etc/ansible/roles/isam-ansible-roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib
